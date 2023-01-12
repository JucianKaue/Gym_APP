import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  XFile? _photo;
  TextStyle LabelTextStyle = TextStyle(color: Colors.black38, fontWeight: FontWeight.w400, fontSize: 20);

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
                    height: 40,
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
                  
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: LabelTextStyle
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: LabelTextStyle
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  
                  TextFormField(
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
                  ),
                  
                  TextFormField(
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
                  ),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'Endereço',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600, ),
                    ),
                  ),
                  TextFormField(
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
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    decoration: InputDecoration(
                      labelText: 'Endereço',
                      labelStyle: LabelTextStyle
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    decoration: InputDecoration(
                      labelText: 'Rua',
                      labelStyle: LabelTextStyle
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Numero',
                      labelStyle: LabelTextStyle
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    decoration: InputDecoration(
                      labelText: 'Complemento',
                      labelStyle: LabelTextStyle
                    ),
                    style: TextStyle(fontSize: 20),
                  ),

              ],)
            )
          ],
        ),
      )
    );
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


