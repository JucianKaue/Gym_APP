import 'dart:async';

import 'package:flutter/material.dart';


class ToDoList extends StatefulWidget {
  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final listKey = GlobalKey<AnimatedListState>();
  final List <Task> tasks= [
    Task('Novo Treino', 'Tenho problemas no joelho', 'Rduinei', '09/01/2022'),
    Task('Preparar Consultoria', 'Cjgfhnkd', 'Robervaldo', '09/01/2022'),
    Task('Preparar Dieta', 'Treino com foco na perna', 'Jucian Decezare', '09/01/2022')
  ];

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('Lista de Tarefas'))
       ),
       body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('Nº de tarefas: 10')
                  ],
                ),
              )
            )
          ),
          Expanded(
            flex: 20,
            child: AnimatedList(
              key: listKey,
              initialItemCount: tasks.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index, animation) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color.fromARGB(112, 207, 163, 4)
                    ),
                    child: Card(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Icon(Icons.fitness_center)
                          ),
                          Expanded(
                            flex: 8,
                            child: ListTaskWidget(
                              task: this.tasks[index],
                              animation: animation,
                              onClicked: () {},
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              child: Icon(Icons.check_box_outline_blank),
                              onTap: () => deleteTask(index),
                            )
                          )
                        ],
                      ),
                    )
                  ),
                );
              }
            ),
          ),
        ],
       ),
     );
   }

  void deleteTask(int _index) {
    tasks.remove(_index);

    listKey.currentState!.removeItem(_index, (context, animation) => ListTaskWidget(
      task: this.tasks[_index],
      animation: animation,
      onClicked: () {},
    ),
    // duration: Duration(milliseconds: 600)
    );
  }
}

class Task {
  String type;
  String description;
  String client;
  String date;
  

  Task(this.type, this.description, this.client, this.date);
}

class ListTaskWidget extends StatelessWidget {
  final Task task;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  const ListTaskWidget({
    required this.task, 
    required this.animation,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) => SizeTransition(
  //   sizeFactor: animation,
  //   child: buildTask(),
  // );
  Widget build(BuildContext context) => buildTask();

  Widget buildTask() => 
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.task.type, style: TextStyle(fontSize: 20)),
                    Text("${this.task.description}", style: TextStyle(fontSize: 14)),
                    SizedBox(height: 10,),
                    Text("Aluno: ${this.task.client}", style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
}

// class ToDoList extends StatefulWidget {
//   @override
//   _ToDoListState createState() => _ToDoListState();
// }

// class _ToDoListState extends State<ToDoList> {
//   List<String> _tasks = [];

//   void _addTask(String task) {
//     setState(() {
//       _tasks.add(task);
//     });
//   }

//   void _removeTask(int index) {
//     setState(() {
//       _tasks.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('To-Do List'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: _tasks.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_tasks[index]),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () => _removeTask(index),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'New Task',
//               ),
//               onSubmitted: (value) => _addTask(value),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
