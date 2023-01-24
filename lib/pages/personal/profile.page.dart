import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';


class ProfilePage extends StatefulWidget {
  int userID;
  ProfilePage(this.userID, {super.key});
  
  @override
  _ProfilePageState createState() => _ProfilePageState(userID);
}

class _ProfilePageState extends State<ProfilePage> {
  int userID;
  _ProfilePageState(this.userID);
  
  Future _getuser() async {
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
    var result = await conn.query("SELECT user.name, user.photo_url, especialty.name, personal.description FROM user JOIN PERSONAL ON personal.user_id = user.id JOIN especialty ON especialty.idespecialty = personal.especialty_id WHERE user.id = ${userID};");
    print(result);
    return result.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    var _themeIcon = Icon(Icons.dark_mode);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: 
    
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: 
        
        FutureBuilder(
          future: _getuser(),
          builder:(context, snapshot) {
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
                              snapshot.data[1],
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
                                    // Linkar para a página de edição
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
                      snapshot.data[0],
                      style: Theme.of(context).textTheme.headline3,
                    )
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Especialidade: ${snapshot.data[2]}",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 16),
                  Text(
                    " ${snapshot.data[3]}",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Text("Altura: $_height cm.", style: Theme.of(context).textTheme.bodyText2,),
                      // Text("Idade: $_age anos", style: Theme.of(context).textTheme.bodyText2,),
                      // Text("Peso: $_weight kg", style: Theme.of(context).textTheme.bodyText2,)
                    ],
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

  newMethod(context, snapshot) async {
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
    final result = conn.query('');
    return Container();
  }

}