import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'package:gym_app/pages/client/availabepersonals.page.dart';
import 'package:gym_app/pages/client/profile.page.dart';

class ClientHomepage extends StatefulWidget {
  int userID;
  ClientHomepage({required this.userID, Key? key}) : super(key: key);

  @override
  State<ClientHomepage> createState() => _ClientHomepageState(userID);
}

class _ClientHomepageState extends State<ClientHomepage> {
  
  int userID;
  _ClientHomepageState(this.userID);
  
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
    print('==================================================1');
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          AvailablePersonals(),
          ProfilePage(userID),
          // Todo List
          // Profile
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
          BottomNavigationBarItem(label: 'Procurar Personal', icon: Icon(Icons.search),),
          BottomNavigationBarItem(label: 'Meu Personal', icon: Icon(Icons.badge)),
          BottomNavigationBarItem(label: 'Meu Treino', icon: Icon(Icons.fitness_center)),
          BottomNavigationBarItem(label: 'Meu Perfil', icon: Icon(Icons.account_circle)),
        ],
        onTap: (index) {
          pc.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.linear);
        },
      ),
    );
  }
}



// class Homepage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ola, PESSOUA'),
//         backgroundColor: Colors.yellowAccent,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(50),
//         child: 
//         Column(children: [
//         ],),
//       ),
//       bottomNavigationBar: DefaultClientBottomNavigationBar()
//     );
//   }
// }