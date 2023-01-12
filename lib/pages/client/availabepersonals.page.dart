import 'package:flutter/foundation.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

class AvailablePersonals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ola, PESSOUA'),
        backgroundColor: Colors.yellowAccent,
      ),
      body: buildListView()
    );
  }

  buildListView() {
    final itens = List<String>.generate(10000, (index) => "Item: ${index}");
    return ListView.builder(
      itemCount: itens.length,
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
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1, 
                              color: Colors.black, 
                              style: BorderStyle.solid
                            )
                          )
                        ),
                        child: Row(
                          children: [
                            // Nome
                            Container(
                              child:Text('Paulo Muzi', style: TextStyle(fontSize: 20))
                            ),
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
                        child: Text('Especialista em: Bodybuilder'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Breve Descrição
                      Container(
                        width: 210,
                        child: Text('Trabalha há mias de 30 anos, atendendo mais de 30 mil pessoas.'),
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
  }
}

