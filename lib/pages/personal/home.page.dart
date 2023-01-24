import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'package:gym_app/pages/personal/clients.page.dart';
import 'package:gym_app/pages/personal/profile.page.dart';
import 'package:gym_app/pages/personal/todolist.page.dart';

class PersonalHomepage extends StatefulWidget {
  int userID;

  PersonalHomepage({Key? key, required this.userID}) : super(key: key);

  @override
  State<PersonalHomepage> createState() => _PersonalHomepageState(userID);
}

class _PersonalHomepageState extends State<PersonalHomepage> {
  _PersonalHomepageState(this.userID);
  int userID;

  int _indexPage = 0;
  late PageController pc;

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
  void initState() {
    super.initState();
    pc = PageController(initialPage: _indexPage);
  }

  setCurrentPage(index) {
    setState(() {
      _indexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          StudentListPage(),
          ToDoList(),
          ProfilePage(userID)
        ],
        onPageChanged: (index) {
          setCurrentPage(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black54,
        currentIndex: _indexPage,
        items: [
          BottomNavigationBarItem(label: 'Meus alunos', icon: Icon(Icons.groups)),
          BottomNavigationBarItem(label: 'Lista de Tarefas', icon: Icon(Icons.checklist)),
          BottomNavigationBarItem(label: 'Meu Perfil', icon: Icon(Icons.account_circle)),
        ],
        onTap: (index) {
          pc.animateToPage(index, duration: Duration(milliseconds: 600), curve: Curves.ease);
        },
      ),
    );
  }
}