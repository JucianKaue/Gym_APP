import 'package:image_picker/image_picker.dart';
import 'package:mysql1/mysql1.dart';

class DataBase {
  var settings = ConnectionSettings(
    host: '192.168.0.112',
    port: 3306,
    user: 'jucian',
    db: 'app_personal',
    password: 'Keua@54893',
    timeout: const Duration(seconds: 10)
  );
}

class User {
  XFile? _photo;

  var _name;
  var _email;
  var _phone;
  var _cpf;

  Address? _address;

  User(photo, name, email, phone, cpf, address) {
    this._photo = photo;
    this._name = name;
    this._email = email;
    this._phone = phone;
    this._cpf = cpf;

    this._address = address;
  }

  
}

class Address {
  var _cep;
  var _address;
  var _street;
  var _number;
  var _complement;

  Address(cep, address, street, number, complement) {
    this._cep = cep;
    this._address = address;
    this._street = street;
    this._number = number;
    this._complement = complement;
  }
}

class Personal {
  var user;

}
