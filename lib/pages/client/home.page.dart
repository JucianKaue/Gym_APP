import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'package:gym_app/utils.dart';
import 'package:gym_app/pages/client/availabepersonals.page.dart';
import 'package:gym_app/pages/client/profile.page.dart';
import 'package:gym_app/pages/client/mypersonal.page.dart';
import 'package:gym_app/pages/client/trainings.dart';

class ClientHomepage extends StatefulWidget {
  int userID;
  ClientHomepage({required this.userID, Key? key}) : super(key: key);

  @override
  State<ClientHomepage> createState() => _ClientHomepageState(userID);
}

class _ClientHomepageState extends State<ClientHomepage> {
  int userID;
  _ClientHomepageState(this.userID);

  List pages = [];
  
  int _indexPage = 0;
  late PageController pc;

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

  Future _getuser() async {
    final conn = await MySqlConnection.connect(DataBase().settings);
    var result = await conn.query("SELECT user.name, user.photo_url, especialty.name_especialty, personal.description FROM user JOIN PERSONAL ON personal.user_id = user.id JOIN especialty ON especialty.id = personal.especialty_id WHERE user.id = $userID;");
    return result.elementAt(0);
  }

  @override
  Widget build(BuildContext context) {
    pages.addAll([
      [
        AvailablePersonals(userID),
        MyPersonalPage(userID),
        TrainigsPage(userID),
        ProfilePage(userID),
      ],
      [
        const BottomNavigationBarItem(label: 'Procurar Personal', icon: Icon(Icons.search)),
        const BottomNavigationBarItem(label: 'Meu Personal', icon: Icon(Icons.badge)),
        const BottomNavigationBarItem(label: 'Meu Treino', icon: Icon(Icons.fitness_center)),
        const BottomNavigationBarItem(label: 'Meu Perfil', icon: Icon(Icons.account_circle)),
      ],
    ]);
    return FutureBuilder(
      future: _getuser(),
      builder: (context, snapshot) {
        return Scaffold(
          body: PageView(
            controller: pc,
            children: pages[0],
            onPageChanged: (index) {
              setCurrentPage(index);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.amber,
            unselectedItemColor: Colors.black54,
            currentIndex: _indexPage,
            items: pages[1],
            onTap: (index) {
              pc.animateToPage(index, duration: const Duration(milliseconds: 600), curve: Curves.linear);
            },
          ),
        );
      },
    );
  }
}