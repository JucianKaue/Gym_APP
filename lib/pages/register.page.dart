import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:gym_app/database.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Profile Picture Variables
  XFile? _photo;
  TextStyle LabelTextStyle = TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 20);

  // Person data controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cpfController = TextEditingController();

  // Person adress controllers
  final _cepController = TextEditingController();
  final _addressController = TextEditingController();
  final _streetController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressComplementController = TextEditingController();

  // User Type Variables
  List<bool> _selections = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Provide the total height and width of the screen

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Registrar'),
            SizedBox(
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
        color: Color.fromARGB(57, 12, 12, 12),
          child:ListView(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Informações do Usuário',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Column(children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            side: BorderSide(width: 2, color: Color.fromARGB(255, 197, 148, 0))
                          ),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: _photo != null ? FileImage(File(_photo!.path)) : null,
                            child: _photo == null ? Icon(Icons.photo_camera) : null
                          ),
                          onPressed: () => _showPickOptionsDialog(context),
                        )
                      ]),
                    ),
                    
                    TextFormField( // Name form field
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _nameController,
                    ),
                    
                    TextFormField( // Email form field
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _emailController,
                    ),
                    
                    TextFormField( // Phone form field
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      decoration: InputDecoration(
                        labelText: 'Celular',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _phoneController,
                    ),
                    
                    TextFormField( // CPF form field
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter()
                      ],
                      decoration: InputDecoration(
                        labelText: 'CPF',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _cpfController,
                    ),
                    
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Endereço',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, ),
                      ),
                    ),

                    TextFormField( // CEP form field
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter()
                      ],
                      decoration: InputDecoration(
                        labelText: 'CEP',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _cepController,
                    ),

                    TextFormField( // Address form field
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _addressController,
                    ),
                    
                    TextFormField( // Street form field
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        labelText: 'Rua',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _streetController,
                    ),
                    
                    TextFormField( // Number form field
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Numero',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      validator: ((value) => _nullformvalidation(value)),
                      controller: _numberController,
                    ),
                    
                    TextFormField( // Address complement form field
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        labelText: 'Complemento',
                        labelStyle: LabelTextStyle
                      ),
                      style: TextStyle(fontSize: 20),
                      controller: _addressComplementController,
                    ),
                    
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Tipo',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    
                    ToggleButtons( // User type select button
                      children: [
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(Icons.person),
                                Text('Aluno')
                              ],
                            ),
                          )
                        ),
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Icon(Icons.fitness_center),
                                Text('Personal')
                              ],
                            ),
                          )
                        )
                      ], 
                      isSelected: _selections,
                      onPressed: ((int index) {
                        setState(() {
                          _selections = List.generate(2, (index) => false);
                          _selections[index] = !_selections[index];
                        });
                      }),
                    ),
                    
                    SizedBox(
                      height: 20,
                    ),
                    
                    ElevatedButton( // Submit button 
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text('CONTINUAR')
                      ),
                      onPressed: () async {
                        
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data'))
                          );
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
                          // Add addres to the dataase
                          var addreses_count = await conn.query('SELECT MAX(id) FROM address;');
                          await conn.query(
                            'INSERT INTO address (id, cep, address, street, number, complement) VALUES (?, ?, ?, ?, ?, ?)',
                            [
                              addreses_count.elementAt(0)[0]+1,
                              _cepController.text,
                              _addressController.text, 
                              _streetController.text,
                              _numberController.text,
                              _addressComplementController.text
                            ]
                          );
                          // Add the user to the database.
                          var users_count = await conn.query('SELECT MAX(id) FROM address;');
                          await conn.query(
                            'INSERT INTO app_personal.user (id, name, photo_url, cpf, typeuser, address_id, email_address, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
                            [
                              users_count.elementAt(0)[0]+1,
                              _nameController.text,
                              '',
                              _cpfController.text,
                              _selections.indexOf(true),
                              addreses_count.elementAt(0)[0]+1,
                              _emailController.text,
                              _phoneController.text
                            ]
                          );
                          
                          if (_selections.indexOf(true) == 0) {
                            
                          } else if (_selections.indexOf(true) == 1) {

                          }
                        }
                      }, 
                    ),
                    SizedBox(height: 30,)
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
  
  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(children: [
                Icon(Icons.photo_library),
                SizedBox(width: 10,),
                Text('Escolha da Galeria'),
              ]),
              onTap: () => _loadPicker(ImageSource.gallery)
            ),
            ListTile(
              title: Row(children: [
                Icon(Icons.photo_camera),
                SizedBox(width: 10,),
                Text('Tire uma photo'),
              ]),
              onTap: () => _loadPicker(ImageSource.camera),
            )
          ]
        ),
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: source);
      if(file != null) setState(() => _photo = file);
    } catch (e) {
      print(e);
    }

    Navigator.pop(context);
  }

}


