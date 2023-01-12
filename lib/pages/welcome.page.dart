import 'package:flutter/material.dart';

import 'package:gym_app/pages/login.page.dart';

class Welcomepage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Provide the total height and width of the screen

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WELCOME TO TRAINING APP',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  child: Text('LOGIN'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
            )
          ],

        )
      )
    );
  }
}


// class Homepage extends StatefulWidget {
//   Homepage({Key? key}) : super(key: key);

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   int _indexPage = 0;
//   late PageController pc;

//   @override
//   void initState() {
//     super.initState();
//     pc = PageController(initialPage: _indexPage);
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: pc,
//         children: [
//           StudentListPage(),
//           ToDoList(),
//           ProfilePage()
//         ],
//         onPageChanged: (index) {
//           setCurrentPage(index);
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Colors.amber,
//         unselectedItemColor: Colors.black54,
//         currentIndex: _indexPage,
//         items: [
//           BottomNavigationBarItem(label: 'Meus alunos', icon: Icon(Icons.groups)),
//           BottomNavigationBarItem(label: 'Lista de Tarefas', icon: Icon(Icons.checklist)),
//           BottomNavigationBarItem(label: 'Meu Perfil', icon: Icon(Icons.account_circle)),
//         ],
//         onTap: (index) {
//           pc.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.linear);
          
//         },
//       ),
//     );
//   }
// }