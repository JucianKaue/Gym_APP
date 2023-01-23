import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'package:gym_app/pages/personal/clients.page.dart';
import 'package:gym_app/pages/personal/profile.page.dart';
import 'package:gym_app/pages/personal/todolist.page.dart';

class PersonalHomepage extends StatefulWidget {
  var personalId;

  PersonalHomepage(this.personalId, {Key? key}) : super(key: key);

  @override
  State<PersonalHomepage> createState() => _PersonalHomepageState();
}

class _PersonalHomepageState extends State<PersonalHomepage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          StudentListPage(),
          ToDoList(),
          ProfilePage()
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
          pc.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.linear);
          
        },
      ),
    );
  }
}