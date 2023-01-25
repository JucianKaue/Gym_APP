import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

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
    var result = await conn.query("SELECT COUNT(*), user.name, user.photo_url, especialty.name_especialty, personal.description FROM user JOIN PERSONAL ON personal.user_id = user.id JOIN especialty ON especialty.id = personal.especialty_id;");
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
                                children:  [
                                  // Nome
                                  Text('${snapshot.data.elementAt(index)["name"]}', style: TextStyle(fontSize: 20)),
                                  
                                  SizedBox(
                                    width: 10,
                                  ),
                                  // grade
                                  Icon(Icons.grade, size: 20),
                                  Icon(Icons.grade, size: 20),
                                  Icon(Icons.grade, size: 20),
                                  Icon(Icons.grade, size: 20),
                                  Icon(Icons.grade, size: 20),
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

