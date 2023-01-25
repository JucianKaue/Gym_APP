import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

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
    final conn = await MySqlConnection.connect(
                  ConnectionSettings(
                    host: '192.168.0.112',
                    port: 3306,
                    user: 'jucian',
                    db: 'app_personal',
                    password: 'Keua@54893',
                    timeout: const Duration(seconds: 10)
                  )
                );
    var result = await conn.query("SELECT COUNT(*), user.name, user.photo_url, especialty.name_especialty, personal.score, personal.description FROM user JOIN PERSONAL ON personal.user_id = user.id JOIN especialty ON especialty.id = personal.especialty_id;");
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

  _buildStarsScore(double number) {
    var decimalPart = number.toString().split('.')[1];

    List<Widget> stars = [];
    for (var i=1; i<=5; i++) {
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
    }

    return stars;
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
    final itens = List<String>.generate(10000, (index) => "Item: ${index}");
    return FutureBuilder(
      future: _getpersonals(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.elementAt(0)[0],
            itemBuilder: (context, index) {
              return ListTile(
                title: Card(
                  margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: _buildStarsScore(4.55),
                                  )
                                  ,
                                ],
                              ),
                            ),
                            // Especialidade
                            Container(
                              width: 210,
                              child: Text('Especialista em: ${snapshot.data.elementAt(index)["name_especialty"]}'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Breve Descrição
                            Container(
                              width: 210,
                              child: Text('${snapshot.data.elementAt(index)["description"]}'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // Botão de ação
                            Container(
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {}, 
                                child: Text('CONTATO'),
                              ),
                            )
                          ],
                        ),
                        
                        Container(width: 70, height: 100, color: Color.fromARGB(255, 76, 244, 54),),
                      ],
                    )
                  ),
                ),
                onLongPress: () => debugPrint('fdsiohgjknvjkxcbjzkvbhjfdhguiohfdvbjkcxbiudfhsg')
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
}

