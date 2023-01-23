import 'package:flutter/material.dart';

import 'package:gym_app/pages/login.page.dart';
import 'package:gym_app/pages/register.page.dart';

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
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: Text('REGISTER'),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage()));
              },
            )
          ],

        )
      )
    );
  }
}