import 'package:mysql1/mysql1.dart';

class DataBase {

  connect() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: '192.168.0.112',
        port: 3306,
        user: 'jucian',
        db: 'app_personal',
        password: 'Keua@54893',
        timeout: const Duration(seconds: 15)
      )
    );       
  }

  _insert() async {
    
  }
}