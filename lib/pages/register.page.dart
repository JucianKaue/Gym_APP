import 'package:flutter/services.dart';
import 'package:gym_app/mixins/validations_mixins.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'package:gym_app/utils.dart';

import 'package:gym_app/pages/client/register.page.dart';
import 'package:gym_app/pages/personal/register.page.dart';

import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  // Profile Picture Variables
  XFile? _photo;
  TextStyle LabelTextStyle = const TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 20);

  // Username and password
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

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
                        'Informações do Usuário',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: Column(children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            side: const BorderSide(width: 2, color: Color.fromARGB(255, 197, 148, 0))
                          ),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: _photo != null ? FileImage(File(_photo!.path)) : null,
                            child: _photo == null ? const Icon(Icons.photo_camera) : null
                          ),
                          onPressed: () => _showPickOptionsDialog(context),
                        )
                      ]),
                    ),

                    TextFormField( // Username form field
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Nome de Usuário',
                        labelStyle: LabelTextStyle
                      ),
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => combine([
                        () => isNotEmpty(value),
                      ])),
                      controller: _usernameController,
                    ),

                    TextFormField( // Password form field
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: LabelTextStyle
                      ),
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
                      controller: _passwordController,
                    ),
                    TextFormField( // Password confirmation form field
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirme a Senha',
                        labelStyle: LabelTextStyle
                      ),
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
                      controller: _passwordConfirmController,
                    ),
                    
                    const SizedBox(height: 10),
                    Divider(),
                    const SizedBox(height: 10),


                    TextFormField( // Name form field
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: LabelTextStyle
                      ),
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
                      controller: _nameController,
                    ),
                    
                    TextFormField( // Email form field
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: LabelTextStyle
                      ),
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
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
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
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
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
                      controller: _cpfController,
                    ),
                    
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
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
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
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
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
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
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
                      controller: _streetController,
                    ),
                    
                    TextFormField( // Number form field
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Numero',
                        labelStyle: LabelTextStyle
                      ),
                      style: const TextStyle(fontSize: 20),
                      validator: ((value) => isNotEmpty(value)),
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
                      style: const TextStyle(fontSize: 20),
                      controller: _addressComplementController,
                    ),
                    
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                        'Tipo',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    
                    ToggleButtons( // User type select button
                      isSelected: _selections,
                      onPressed: ((int index) {
                        setState(() {
                          _selections = List.generate(2, (index) => false);
                          _selections[index] = !_selections[index];
                        });
                      }), // User type select button
                      children: [
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: const [
                                Icon(Icons.person),
                                Text('Aluno')
                              ],
                            ),
                          )
                        ),
                        SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: const [
                                Icon(Icons.fitness_center),
                                Text('Personal')
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                    
                    const SizedBox(
                      height: 20,
                    ),
                    
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
                          var addreses_count = (await conn.query('SELECT MAX(id) FROM address;')).elementAt(0)[0];
                          if (addreses_count == null) {addreses_count = 0;} else {addreses_count = addreses_count+1;};
                          await conn.query(
                            'INSERT INTO address (id, cep, address, street, number, complement) VALUES (?, ?, ?, ?, ?, ?)',
                            [
                              addreses_count,
                              _cepController.text,
                              _addressController.text, 
                              _streetController.text,
                              _numberController.text,
                              _addressComplementController.text
                            ]
                          );
                          // Add the user to the database.
                          int? users_count = (await conn.query('SELECT MAX(id) FROM address;')).elementAt(0)[0];
                          if (users_count == null) {users_count = 0;} else {users_count = users_count+1;};
                          await conn.query(
                            'INSERT INTO app_personal.user (id, username, password, name, photo_url, cpf, typeuser, address_id, email_address, phone) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                            [
                              users_count,
                              _usernameController.text,
                              _passwordController.text,
                              _nameController.text,
                              users_count,
                              _cpfController.text,
                              _selections.indexOf(true),
                              addreses_count,
                              _emailController.text,
                              _phoneController.text
                            ]
                          );
                          
                          print(_selections.indexOf(true) == 1);
                          if (_selections.indexOf(true) == 0) {
                            
                          } else if (_selections.indexOf(true) == 1) {
                            sleep(const Duration(seconds: 1));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPersonalPage(users_count)));
                          }
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

  // _nullformvalidation(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Esse campo não pode estar vazio!!!';
  //   }
  //   return null;
  // }

  // _usernameFormValidation(value) async {
  //   if (value == null || value.isEmpty) {
  //     return 'Esse campo não pode estar vazio!!!';
  //   } 
    
  // }

  // _passwordValidation(value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Esse campo não pode estar vazio!!!';
  //   } else if (_passwordConfirmController.text != _passwordController.text) {
  //     return 'As senhas não são iguais';
  //   }
  //   return null;
  // }
  
  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(children: const [
                Icon(Icons.photo_library),
                SizedBox(width: 10,),
                Text('Escolha da Galeria'),
              ]),
              onTap: () => _loadPicker(ImageSource.gallery)
            ),
            ListTile(
              title: Row(children: const [
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


