import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:gym_app/utils.dart';


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
    final conn = await MySqlConnection.connect(DataBase().settings);
    var result = await conn.query("SELECT user.name, user.photo_url, especialty.name_especialty, personal.description FROM user JOIN PERSONAL ON personal.user_id = user.id JOIN especialty ON especialty.id = personal.especialty_id WHERE user.id = $userID;");
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
        child: FutureBuilder(
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