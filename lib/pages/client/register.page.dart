import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/pages/login.page.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/mixins/validations_mixins.dart';
import 'package:numberpicker/numberpicker.dart';


class RegisterClientPage extends StatefulWidget {
  var userId;
  
  RegisterClientPage(this.userId, {super.key});

  @override
  State<RegisterClientPage> createState() => _RegisterClientPageState(userId);
}

class _RegisterClientPageState extends State<RegisterClientPage> with ValidationMixin {
  var userId;
  
  // Forms variables
  final _formKey = GlobalKey<FormState>();

  final _objective = ValueNotifier(''); // Selected value from dropdown menu
  final List _dropDownObjectives = [
    [0, 'Emagrecimento'],
    [1, 'Ganho de massa muscular']
  ];

  final _descriptionController = TextEditingController();
  final _limitationController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();


  _RegisterClientPageState(this.userId);

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
                        'Informações do Aluno',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, ),
                      ),
                    ),

                    const SizedBox(height: 50),
                    
                    ValueListenableBuilder( // Objective select form field
                      valueListenable: _objective, 
                      builder: (BuildContext context, String value, _) {
                        return DropdownButtonFormField<String>(
                          isExpanded: true,
                          hint: const Text('Escolha o seu objetivo'),
                          value: (value.isEmpty) ? null : value,
                          onChanged: (value) => _objective.value = value.toString(),
                          items: _dropDownObjectives.map((option) => DropdownMenuItem(
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

                    TextFormField( // Description/Biography  form field
                      minLines: 2,
                      maxLines: 5,
                      maxLength: 150,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Descrição / Biografia',
                      ),
                      style: const TextStyle(fontSize: 20),
                      controller: _descriptionController,
                      validator: (value) => combine([
                        () => isNotEmpty(value),
                        () => maxLength(value, 150) 
                      ]),
                    ),

                    TextFormField( // Limitations form field
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Limitações (ex: problema no joelho)',
                      ),
                      style: const TextStyle(fontSize: 20),
                      controller: _limitationController,
                      validator: (value) => maxLength(value, 100)
                    ),

                    TextFormField( // Age form field
                      maxLength: 3,
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        FilteringTextInputFormatter.deny('.')
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Idade',
                      ),
                      validator: (value) => combine([
                        () => isNotEmpty(value),
                        () => isAge(int.tryParse('$value')),
                      ]),
                      style: const TextStyle(fontSize: 20),
                      controller: _ageController,
                    ),

                    TextFormField( // Height form field
                      maxLength: 3,
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                        FilteringTextInputFormatter.deny('.')
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Altura (cm)',
                      ),
                      validator: (value) => combine([
                        () => isNotEmpty(value), 
                        () => isHeight(int.tryParse('$value')),
                      ]),
                      style: const TextStyle(fontSize: 20),
                      controller: _heightController,
                    ),

                    TextFormField( // Weight form field
                      maxLength: 5,
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        PesoInputFormatter()
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Peso (em Kg)',
                      ),
                      validator: (value) => isWeigth(int.tryParse('${"$value".split(',')[0]}')),
                      style: const TextStyle(fontSize: 20),
                      controller: _weightController,
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
                          print(_objective.value);
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
                            'INSERT INTO app_personal.client (User_id, limitation, age, height, weight, description, especialty_id) VALUES (?, ?, ?, ?, ?, ?, ?)',
                            [
                              userId,
                              _limitationController.text,
                              _ageController.text,
                              _heightController.text,
                              _weightController.text,
                              _descriptionController.text,
                              _objective.value,
                            ]
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
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


}