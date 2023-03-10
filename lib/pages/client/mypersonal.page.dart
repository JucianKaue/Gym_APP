import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:gym_app/utils.dart';

class MyPersonalPage extends StatefulWidget {
  int userID;
  MyPersonalPage(this.userID);

  @override
  _MyPersonalPageState createState() => _MyPersonalPageState(userID);
}

class _MyPersonalPageState extends State<MyPersonalPage> {
  int userID;
  _MyPersonalPageState(this.userID);
  
  Future _getuser() async {
    final conn = await MySqlConnection.connect(DataBase().settings);
    var result = await conn.query("""SELECT user.name, e.name_especialty, user.photo_url, p.description FROM client c 
                                  JOIN client_has_personal cp ON c.user_id = cp.client_user_id
                                  JOIN personal p ON cp.personal_user_id = p.user_id
                                  JOIN especialty e ON e.id = p.especialty_id
                                  JOIN user ON user.id = p.user_id WHERE c.user_id = 1;""");
    return result.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    var _themeIcon = Icon(Icons.dark_mode);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Meu Personal'))
      ),
      body: 
    
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: _getuser(),
          builder:(context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Image.network(
                              snapshot.data['photo_url'],
                              width: 150,
                              height: 150,
                              errorBuilder: ((context, error, stackTrace) => Image.asset('assets/generic-person-icon.png', height: 150, width: 150,)),
                            )
                          )
                        ),
                        ClipOval(
                          child:  Container(
                            padding: EdgeInsets.all(2),
                            color: Colors.white,
                            child: ClipOval(
                              child: Container(
                                padding: EdgeInsets.all(7),
                                color: Color.fromARGB(255, 255, 219, 59),
                                child: InkWell(
                                  child: Icon(Icons.edit),
                                  onTap: () {
                                    // Linkar para a p??gina de edi????o
                                    print('hi');
                                  },
                                ),
                              ),
                            ),
                          )
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      snapshot.data['name'],
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Especialidade: ${snapshot.data['name_especialty']}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 16),
                  Text(
                    " ${snapshot.data['description']}",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      )
    );
  }
}


