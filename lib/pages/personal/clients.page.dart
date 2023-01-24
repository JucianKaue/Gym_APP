import 'package:flutter/material.dart';


class StudentListPage extends StatefulWidget {
  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final List<Student> students = [
    Student('Leticia', 'Ganhar massa', 'https://img.freepik.com/fotos-gratis/mulher-com-rosto-serio_1149-1729.jpg?w=200'),
    Student('Jucian', 'Perder Peso', 'https://instagram.fxap4-1.fna.fbcdn.net/v/t51.2885-19/165790675_484014792629498_3502541952523653363_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fxap4-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=eYGcKnsA3M0AX_WaObw&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfAsT38TD8GIYlVe1c4iJdKukR24M6ZJC4qsl32qlIUUoA&oe=63C031AC&_nc_sid=1527a3')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Alunos'))
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentCard(students[index]);
        },
      )
    );
  }
}

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard(this.student);

  @override
  Widget build(BuildContext context) {
    return 
    Card(
      child: InkWell(
        onLongPress: () {
          // Abrir perfil do aluno.
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        this.student.photo,
                        width: 64,
                        height: 64,
                        errorBuilder: ((context, error, stackTrace) => Image.asset('assets/generic-person-icon.png', height: 64, width: 64,)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.student.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${this.student.objective}'),
                      ],
                    ),
                  ],)
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child: InkWell(
                        onTap: () {
                          // Abrir char com o aluno
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Colors.amberAccent,
                          child: const Icon(Icons.chat, size: 16,)
                        )
                      )                    
                    ),
                  ),
                ),
            ],
          ),
        ),
      )
    );
  }
}

class Student {
  String name;
  String objective;
  String photo;

  Student(this.name, this.objective, this.photo );
}