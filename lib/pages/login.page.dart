import 'package:flutter/material.dart';
import 'register.page.dart';
import 'package:gym_app/mixins/validations_mixins.dart';
import 'package:mysql1/mysql1.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:gym_app/utils.dart';

import 'package:gym_app/pages/personal/home.page.dart';
import 'package:gym_app/pages/client/home.page.dart';

class LoginPage extends StatelessWidget with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  // _checkLocalUser() async {
  //   final db = await openDatabase(
  //     join(await getDatabasesPath(), 'user.db'),
  //     onCreate: (db, version) {
  //       return db.execute('CREATE TABLE user(username VARCHAR(45), password VARCHAR(45));');
  //     },
  //   );

  //   print(await db.query('user'));

  //   return await db.query('user');
  // }
// _saveLocalUser(username, password) async {
//     final db = await openDatabase(
//       join(await getDatabasesPath(), 'user.db'),
//       onCreate: (db, version) {
//         return db.execute('CREATE TABLE user(username VARCHAR(45), password VARCHAR(45));');
//       },
//     );
//     db.insert('user', {'username': username, 'password': password});
//   }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40
        ),
        color: const Color.fromARGB(57, 12, 12, 12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget> [
              const SizedBox(height: 70),
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset('assets/logo.png'),
              ),
              const SizedBox(height: 70),
              TextFormField( // username
                keyboardType: TextInputType.text,
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Nome de Usuário',
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                    )
                ),
                style: const TextStyle(fontSize: 20),
                validator: ((value) => combine([
                          () => isNotEmpty(value),
                          () => isValidUsername(value),
                          () => minLength(value, 4),
                          () => maxLength(value, 45)
                        ])),
              ),
              const SizedBox(height: 30),
              TextFormField( // password
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                  )
                ),
                style: const TextStyle(fontSize: 20),
                validator: ((value) => combine([
                          () => isNotEmpty(value),
                          () => isValidPassword(value),
                          () => maxLength(value, 45)
                        ])),
              ),
              const SizedBox(height: 50),
              Center(
                child: SizedBox(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20)
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final conn = await MySqlConnection.connect(DataBase().settings);
                        var user = await conn.query("SELECT id, typeuser FROM user WHERE username='${_usernameController.text}' AND password='${_passwordController.text}';");
                        if (user.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Usuário ou senha incorreto!'))
                          );
                        } else {
                          // _saveLocalUser(_usernameController.text, _passwordController.text);
                          if (user.elementAt(0)[1] == 0) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ClientHomepage(userID: user.elementAt(0)[0])));
                          } else if (user.elementAt(0)[1] == 1) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PersonalHomepage(userID: user.elementAt(0)[0])));
                          }
                        }
                        print(user);
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  child: const Text('Ainda não tem uma conta?', style: TextStyle(color: Color.fromARGB(255, 2, 14, 49)),),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => RegisterPage())),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}