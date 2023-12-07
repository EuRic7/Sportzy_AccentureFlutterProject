import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'fooderlich_theme.dart';
///Este é o ponto de entrada principal da aplicação Flutter. Contém a função main que inicializa o aplicativo.
class PerfilPage extends StatefulWidget {
  String? nome = "@Desafiante";
  String? image = "assets/profile_pics/person_manda.png";

  PerfilPage({this.nome, this.image});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Lista de caminhos das imagens dos posts
  final List<String> postImages = [
    "assets/icons/post_image3.jpeg",
    "assets/icons/post_image2.jpeg",
    "assets/icons/post_image.jpeg",
    "assets/icons/post_image2.jpeg",
    "assets/icons/post_image3.jpeg",
    "assets/icons/post_image2.jpeg",
    "assets/icons/post_image.jpeg",
    "assets/icons/post_image2.jpeg",
    "assets/icons/post_image.jpeg",
    "assets/icons/post_image3.jpeg",
    // Adicione mais caminhos conforme necessário
  ];

  @override
  Widget build(BuildContext context) {
    MaterialApp(theme: tema);
    _logout() {
      FirebaseAuth.instance.signOut().then((result) {
        Navigator.of(context).pushNamedAndRemoveUntil("/login", (_) => false);
      });
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Container(
        child: Text("User not found"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Sportzy', style: TextStyle(fontSize: 30)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: "Sair",
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Container(
          //  height: 40,
          //  width: MediaQuery.of(context).size.width,
          //child: //Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //children: [
          // Row(
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.arrow_back),
          //       onPressed: () {
          //         Navigator.pushNamed(context, '/main');
          //       },
          //     ),
          //   ],
          // ),
          //Padding(
          //  padding: EdgeInsets.all(8),
          //  child: Text(
          //    "Sportzy",
          //    style: TextStyle(
          //      fontSize: 20,
          //      fontWeight: FontWeight.bold,
          //    ),
          //  ),
          //),
          // Row(
          // children: [
          //IconButton(
          //  icon: Icon(Icons.logout),
          //  onPressed: _logout,
          //  tooltip: "Sair",
          // ),
          //],
          //),
          // ],
          // ),
          // ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " 8",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(" Desafios Vencidos e"),
                Text(
                  " 3 ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(" Eventos criados este mês"),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.2,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4.3,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(widget.image!),
                        ),
                        SizedBox(height: 8),
                        Text(
                          (widget.nome!),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8), // Adiciona espaço entre a foto e os eventos
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "655",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Desafios",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "185",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Eventos",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('10', style: TextStyle(fontSize: 25)),
              Icon(
                Icons.emoji_events,
                color: Colors.yellow,
                size: 50,
              ),
              Text('Vitórias', style: TextStyle(fontSize: 16))
            ],
          ),
          SizedBox(height: 16), // Adiciona espaço entre as seções

          SizedBox(height: 6),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: postImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _mostrarImagemFullscreen(context, postImages[index]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(postImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Função para mostrar a imagem em tela cheia
  void _mostrarImagemFullscreen(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
