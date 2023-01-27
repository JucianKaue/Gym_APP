import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';


class ClientListPage extends StatefulWidget {
  int userID;

  ClientListPage({super.key, required this.userID});
 
  

  @override
  State<ClientListPage> createState() => _ClientListPageState(userID: userID);
}

class _ClientListPageState extends State<ClientListPage> {
  int userID;
  _ClientListPageState({required this.userID});

  _getClients() async {
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
    var result = await conn.query("SELECT client_user_id, name, photo_url, name_especialty, state FROM user JOIN client ON client.user_id = user.id JOIN client_has_personal ON client_User_id = client.user_id JOIN especialty ON especialty.id = client.especialty_id WHERE client_has_personal.personal_User_id = ${userID};");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Alunos'))
      ),
      body: FutureBuilder(
        future: _getClients(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ClientCard(Client(
                  snapshot.data.elementAt(index)["client_user_id"],
                  snapshot.data.elementAt(index)["name"],
                  snapshot.data.elementAt(index)["name_especialty"],
                  snapshot.data.elementAt(index)["photo_url"],
                  snapshot.data.elementAt(index)["state"]
                ));
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

}

class ClientCard extends StatelessWidget {
  final Client client;

  ClientCard(this.client);

  @override
  Widget build(BuildContext context) {
    return 
    Card(
      child: InkWell(
        onTap: () {
          // Abrir perfil do aluno.
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        this.client.photo,
                        width: 64,
                        height: 64,
                        errorBuilder: ((context, error, stackTrace) => Image.asset('assets/generic-person-icon.png', height: 64, width: 64,)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.client.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${this.client.objective}'),
                      ],
                    ),
                  ],)
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipOval(
                      child:
                        this.client.state == 'CONFIRMAÇÃO DO PERSONAL PENDENTE' ? 
                          Row(children: [
                            ClipOval(
                              child: InkWell(
                                onTap: () async {
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
                                  conn.query("UPDATE client_has_personal SET state = 'RECUSADA PELO PERSONAL' WHERE client_user_id = ${this.client.id}");
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.red,
                                  child: Icon(Icons.cancel, size: 16,)
                                ),
                              )
                            ),
                            ClipOval(
                              child: InkWell(
                                onTap: () async {
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
                                  conn.query("UPDATE client_has_personal SET state = 'PAGAMENTO PENDENTE' WHERE client_user_id = ${this.client.id}");
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.green,
                                  child: Icon(Icons.task_alt, size: 16,)
                                ),
                              ),
                            )
                          ],)
                           :       
                        InkWell(
                            onTap: () {
                              // Abrir char com o aluno
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              color: this.client.state == '' ? Colors.amberAccent : Colors.green,
                              child: this.client.state == '' ? Icon(Icons.chat, size: 16,) : Icon(Icons.task_alt, size: 16,)
                            ) 
                          )             
                    ),
                  ),
                ),
            ],
          ),
        ),
      )
    );
  }

}

class Client {
  int id;
  String name;
  String objective;
  String photo;
  String state;

  Client(this.id, this.name, this.objective, this.photo, this.state);
}