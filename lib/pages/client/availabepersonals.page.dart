import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:gym_app/utils.dart';

// This custom clipper help us achieve n-pointed star shape
class StarClipper extends CustomClipper<Path> {
  /// The number of points of the star
  final int points;
  StarClipper(this.points);

  // Degrees to radians conversion
  double _degreeToRadian(double deg) => deg * (math.pi / 180.0);

  @override
  Path getClip(Size size) {
    Path path = Path();
    double max = 2 * math.pi;

    double width = size.width;
    double halfWidth = width / 2;

    double wingRadius = halfWidth;
    double radius = halfWidth / 2;

    double degreesPerStep = _degreeToRadian(360 / points);
    double halfDegreesPerStep = degreesPerStep / 2;

    path.moveTo(width, halfWidth);

    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(halfWidth + wingRadius * math.cos(step),
          halfWidth + wingRadius * math.sin(step));
      path.lineTo(halfWidth + radius * math.cos(step + halfDegreesPerStep),
          halfWidth + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    return path;
  }

  // If the new instance represents different information than the old instance, this method will return true, otherwise it should return false.
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    StarClipper starClipper = oldClipper as StarClipper;
    return points != starClipper.points;
  }
  
}

class AvailablePersonals extends StatelessWidget {
  int userID;
  AvailablePersonals(this.userID);
  

  Future _getpersonals() async {
    final conn = await MySqlConnection.connect(DataBase().settings);
    var result = await conn.query("SELECT user.id, user.name, user.photo_url, especialty.name_especialty, personal.score, personal.description FROM user JOIN PERSONAL ON personal.user_id = user.id JOIN especialty ON especialty.id = personal.especialty_id;");
    return result;
  }

  // Future _getUser() async {
  //   final conn = await MySqlConnection.connect(
  //                 ConnectionSettings(
  //                   host: '192.168.0.112',
  //                   port: 3306,
  //                   user: 'jucian',
  //                   db: 'app_personal',
  //                   password: 'Keua@54893',
  //                   timeout: const Duration(seconds: 10)
  //                 )
  //               );
  //   var result = (await conn.query("SELECT name FROM user WHERE id = $userID")).elementAt(0);
  //   return result;
  // }

  _buildStarsScore(double? number) {
    if (number == null) {
      return const SizedBox(height: 0,);
    }

    var integerPart = int.parse(number.toString().split('.')[1]);
    var decimalPart = number.toString().split('.')[1];

    List<Widget> stars = [];
    for (int i=1; i<=5; i++) {
      if (number > i) {
        stars.add(
          SizedBox(
            height: 20,
            width: 20,
            child: ClipPath(
              clipper: StarClipper(5),
              child: Container(
                height: 150,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(color: Colors.amber,)
                    ),
                ],)
              ),
            ),
          )
        );
      } else if ('${number.toInt()}' == '$i') {
        if ('$decimalPart' == '0') {
          stars.add(
            SizedBox(
              width: 20,
              height: 20,
              child: ClipPath(
                clipper: StarClipper(5),
                child: Container(
                  height: 150,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(color: Colors.amber,)
                      ),
                  ],)
                ),
              ),
            )
          );
        } else {
          stars.add(
            SizedBox(
              width: 20,
              height: 20,
              child: ClipPath(
                clipper: StarClipper(5),
                child: Container(
                  height: 150,
                  child: Row(
                    children: [
                      Flexible(
                        flex: int.parse(decimalPart),
                        child: Container(color: Colors.amber,)
                      ),
                      Flexible(
                        flex: (int.parse(decimalPart)-math.pow(10, decimalPart.length).toInt())*(-1),
                        child: Container(color: Color.fromARGB(255, 117, 117, 117),)
                      ),
                  ],)
                ),
              ),
            )
          );
        }
      } else if (number < i) {
        stars.add(
          SizedBox(
            width: 20,
            height: 20,
            child: ClipPath(
              clipper: StarClipper(5),
              child: Container(
                height: 150,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(color: Color.fromARGB(255, 117, 117, 117),)
                    ),
                ],)
              ),
            ),
          )
        );
      }
    }

    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text('Personais Disponíveis'))
            ),
            body: buildListView()
          );
  }

  buildListView() {
    return FutureBuilder(
      future: _getpersonals(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Card(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(children: [
                              Container(
                                width: 220,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1, 
                                      color: Colors.black, 
                                      style: BorderStyle.solid
                                    )
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    // Nome
                                    Text('${snapshot.data.elementAt(index)["name"].split(" ")[0]}', style: const TextStyle(fontSize: 20)),
                                    
                                    // grade
                                    _buildStarsScore(double.tryParse(snapshot.data.elementAt(index)["score"].toString())),
                                    
                                  ],
                                ),
                              ),
                              const SizedBox(height: 3,),
                              // Especialidade
                              Container(
                                width: 210,
                                child: Text('Área principal: ${snapshot.data.elementAt(index)["name_especialty"]}'),
                              ),
                              
                            ],),
                            
                            // Botão de ação
                            Container(
                              width: 150,
                              child: ElevatedButton(
                                //photo_url, name, description, score, id
                                onPressed: () => _personalPopUpView(context, {
                                  'name': snapshot.data.elementAt(index)['name'],
                                  'photo_url': snapshot.data.elementAt(index)['photo_url'],
                                  'description': snapshot.data.elementAt(index)['description'],
                                  'score': snapshot.data.elementAt(index)['score'],
                                  'id': snapshot.data.elementAt(index)['id']
                                }), 
                                child: Center(
                                  child: Column(
                                    children: [Text('MAIS'), Text('INFORMAÇÕES')],
                                  )
                                )
                              ),
                            )
                          ],
                        ),
                        
                        Container(width: 70, height: 100, color: Color.fromARGB(255, 76, 244, 54),),
                      ],
                    )
                  ),
                ),
                onLongPress: () {
                  showDialog(
                    context: context, 
                    builder: (context) => 
                    AlertDialog(
                      content: Container(
                        width: 200,
                        height: 200,
                        color: Color.fromARGB(255, 250, 241, 157),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding( // Profile Picture of the personal
                              padding: EdgeInsets.only(top: 5),
                              child: Center( 
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Image.network(
                                      snapshot.data.elementAt(index)['photo_url'],
                                      width: 100,
                                      height: 100,
                                      errorBuilder: ((context, error, stackTrace) => Image.asset('assets/generic-person-icon.png', height: 100, width: 100,)),
                                    )
                                  )
                                ),
                              ),
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text('Nota: ${snapshot.data.elementAt(index)["score"]}'),
                            )
                            
                          ]
                          
                        ),

                      ),
                    )
                  );
                }
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
      )
  
    );
  }

  _personalPopUpView (context, personal_info) {
    // photo_url, name, description, score, id
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.4,
          color: Color.fromARGB(5, 189, 255, 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding( // Profile Picture and full name of the personal
                padding: EdgeInsets.only(top: 5),
                child: 
                  Center( 
                    child: Column(children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Image.network(
                            personal_info['photo_url'],
                            width: 100,
                            height: 100,
                            errorBuilder: ((context, error, stackTrace) => Image.asset('assets/generic-person-icon.png', height: 100, width: 100,)),
                          )
                        )
                      ),
                      const SizedBox(height: 5),
                      Text(
                        personal_info["name"], 
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20
                        ),
                      )
                    ],)
                  ),

              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  children: [
                    Text('Descrição: ${personal_info["description"]}'),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    Text('Nota: ${personal_info["score"]}'),
                ],)
              )
            ]
          ),
        ),
          
        actions: <Widget>[
          TextButton(
            child: Text("CONTRATAR"),
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 7, 65, 255))),
            onPressed: () async {
              final conn = await MySqlConnection.connect(DataBase().settings);
              try {
                conn.query('INSERT INTO client_has_personal VALUES (?, ?, ?)', [userID, personal_info['id'], 'CONFIRMAÇÃO DO PERSONAL PENDENTE']);
              } catch (e) {
                print(e);
              }

              Navigator.pop(context);
              return showDialog(
                context: context, 
                builder: (context) {
                  return 
                  AlertDialog(
                    content: Text('A solicitação foi enviada ao personal.\nFique atento, te avisaremos assim que ele responder'),
                    
                    actions:  [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        child: Center(child:Text('OK', style: TextStyle(fontWeight: FontWeight.bold),))
                      ),
                    ],
                  );
                }
              );
          
              
            
            })
        ],
      )
    );
  }
}


