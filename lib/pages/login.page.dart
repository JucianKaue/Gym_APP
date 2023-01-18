import 'package:flutter/material.dart';
import 'register.page.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40
        ),
        color: Color.fromARGB(57, 12, 12, 12),
        child: ListView(
          children: <Widget> [
            SizedBox(
              height: 70,
            ),
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset('assets/logo.png'),
            ),
            SizedBox(
              height: 70,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                  )
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20
                )
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                width: 120,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)
                  ),
                  onPressed: () {

                  },
                  child: const Text('Entrar'),
                ),
              ),
            ),
            Center(
              child: InkWell(
                child: Text('Ainda não tem uma conta?'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPage())),
              ),
            )
          ],
          ),
        ),
    );
  }
}