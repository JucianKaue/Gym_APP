import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Jucian Kauê Decezare';
  String _specialty = 'Especialista em Musculação';
  String _description = 'Mias de 95 anos trabalhando com Musculação';
  String _profilePicture = 'https://instagram.fxap4-1.fna.fbcdn.net/v/t51.2885-19/165790675_484014792629498_3502541952523653363_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.fxap4-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=eYGcKnsA3M0AX_WaObw&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfAsT38TD8GIYlVe1c4iJdKukR24M6ZJC4qsl32qlIUUoA&oe=63C031AC&_nc_sid=1527a3';
  String _goal = 'Perder peso';
  int _height = 179;
  int _age = 18;
  int _weight = 78;


  @override
  Widget build(BuildContext context) {
    var _themeIcon = Icon(Icons.dark_mode);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: NetworkImage(_profilePicture),
                        width: 150,
                        height: 150,
                        child: InkWell(onTap: () {
                          // Linkar para a página de editar a foto
                        },),
                      )
                    )
                  ),
                  ClipOval(
                    child:  Container(
                      padding: EdgeInsets.all(2),
                      color: Colors.white,
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(7),
                          color: Color.fromARGB(255, 255, 219, 59),
                          child: InkWell(
                            child: Icon(Icons.edit),
                            onTap: () {
                              // Linkar para a página de edição
                            },
                          ),
                        ),
                      ),
                    )
                  )
                ]
              )
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                _name,
                style: Theme.of(context).textTheme.headline3,
              )
            ),
            SizedBox(height: 10),
            Text(
              "Especialidade: $_specialty",
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16),
            Text(
              " $_description",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text("Altura: $_height cm.", style: Theme.of(context).textTheme.bodyText2,),
                // Text("Idade: $_age anos", style: Theme.of(context).textTheme.bodyText2,),
                // Text("Peso: $_weight kg", style: Theme.of(context).textTheme.bodyText2,)
              ],
            ),

            
          ],
        ),
      )
    );
  }
}