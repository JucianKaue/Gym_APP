import 'package:flutter/services.dart';
import 'package:gym_app/pages/login.page.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'package:gym_app/utils.dart';


class RegisterPersonalPage extends StatefulWidget {
  var userId;
  
  RegisterPersonalPage(this.userId, {super.key});

  @override
  State<RegisterPersonalPage> createState() => _RegisterPersonalPageState(userId);
}

class _RegisterPersonalPageState extends State<RegisterPersonalPage> {
  var userId;
  
  // Forms variables
  final _formKey = GlobalKey<FormState>();

  final _especialty = ValueNotifier(''); // Selected value from dropdown menu
  final List _dropDownEspecialties = [
    [0, 'Emagrecimento'],
    [2, 'Ganho de massa']
  ];


  final _descriptionController = TextEditingController();

  _RegisterPersonalPageState(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Registrar'),
            const SizedBox(
              width: 5,
            ),
            SizedBox(
              height: 32,
              width: 32,
              child: Image.asset('assets/logo.png'),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(57, 12, 12, 12),
          child:ListView(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Informações do Personal',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, ),
                      ),
                    ),

                    const SizedBox(height: 50),
                    
                    ValueListenableBuilder(
                      valueListenable: _especialty, 
                      builder: (BuildContext context, String value, _) {
                        return DropdownButtonFormField<String>(
                          isExpanded: true,
                          hint: const Text('Escolha a sua especialidade'),
                          value: (value.isEmpty) ? null : value,
                          onChanged: (value) => _especialty.value = value.toString(),
                          items: _dropDownEspecialties.map((option) => DropdownMenuItem(
                            value: '${option[0]}',
                            child: Text(option[1]),
                          )).toList(),
                          decoration: InputDecoration(
                            label: const Text('Objetivo', style: TextStyle(fontSize: 20),),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                          iconSize: 30,
                        );
                      }
                    ),

                    const SizedBox(height: 20),

                    TextFormField( // Address complement form field
                      minLines: 2,
                      maxLines: 5,
                      maxLength: 150,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        labelText: 'Descrição / Biografia',
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: _descriptionController,
                    ),

                    const SizedBox(height: 50),

                    ElevatedButton( // Submit button 
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('CONTINUAR')
                      ),
                      onPressed: () async {
                        
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data'))
                          );
                          print('================================================');
                          print(_especialty.value);
                          print(_descriptionController.text);
                          print(userId);
                          // Connect to the database
                          final conn = await MySqlConnection.connect(
                            ConnectionSettings(
                              host: '192.168.0.112',
                              port: 3306,
                              user: 'jucian',
                              db: 'app_personal',
                              password: 'Keua@54893',
                              timeout: const Duration(seconds: 10)
                            )
                          );
                          await conn.query(
                            'INSERT INTO app_personal.personal (especialty_id, description, User_id) VALUES (?, ?, ?)',
                            [
                              _especialty.value,
                              _descriptionController.text,
                              userId,
                            ]
                          );

                          
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        }
                      }, 
                    ),
                    const SizedBox(height: 30,)
                ],)
              )
            )
          ],
        ),
      )
    );
  }
  
  _nullformvalidation(value) {
    if (value == null || value.isEmpty) {
      return 'Esse campo não pode estar vazio!!!';
    } 
    return null;
  }
}