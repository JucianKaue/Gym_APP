import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'pages/welcome.page.dart';

import 'package:gym_app/pages/register.page.dart';


void main() async {
  runApp(MyApp());

  /* final conn = await MySqlConnection.connect(
    ConnectionSettings(
      host: '192.168.0.112',
      port: 3306,
      user: 'testapp',
      db: 'trabalho_cassiano',
      password: '123'
    )
  );

  var result = await conn.query('SELECT * FROM pessoa;');
  print(result); */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          headline3: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 30.0),
          bodyText1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Hind'),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        )
      ),
      home: RegisterPage(),
    );
  }
}