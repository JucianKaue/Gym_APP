import 'package:flutter/material.dart';


class WorkoutListPage extends StatefulWidget {
  @override
  State<WorkoutListPage> createState() => new _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  final List<Workout> workouts = [
    Workout('Treino A', 'Perna', 30),
    Workout('Treino B', 'Peito e Tríceps', 60),
    Workout('Treino C', 'Peito e costas', 45),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Treinos'),
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return WorkoutCard(workouts[index]);
        },
      )
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final Workout workout;

  const WorkoutCard(this.workout);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: InkWell(
          onLongPress: () {
            // Direcionar para a página de detalhes do treino.
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.workout.name,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(
                  height: 8,
                ),

                Text(
                  'Objetivo: ${this.workout.goal}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Duração: ${this.workout.time} minutos',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        )
        
      )
    );
      
  }
}

class Workout {
  final String name;
  final String goal;
  final int time;

  Workout(this.name, this.goal, this.time);
}
