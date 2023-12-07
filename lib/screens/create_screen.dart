import 'dart:io';

import 'package:Sportzy/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Sportzy/pages/formArenaCreate_page.dart';
import 'package:Sportzy/pages/formPartidaCreate_page.dart';
import 'package:Sportzy/pages/formServicoCreate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
///Este arquivo pode conter a implementação de uma tela ou conjunto de telas responsáveis pela criação de conteúdos na aplicação. O nome sugere que essa tela ou conjunto de telas está associado à criação de algo, mas sem o código fonte específico, é difícil fornecer detalhes adicionais.
class CreatePostContent extends StatelessWidget {
  File imagePath = File("");
  final ImagePicker _imagePicker = ImagePicker();

  // função usada para conseguir pegar o caminho da imagem
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = File(pickedFile.path);
    } else {
      print('Nenhuma imagem selecionada.');
    }
  }

  //função usada para conseguir solicitar persimção e abrir galeria
  Future<void> _getGalleryPermissionAndPickImage() async {
    var status = await Permission.photos.status;
    if (status.isGranted) {
      // Permissão já concedida, então podemos escolher a imagem
      _pickImage();
    } else {
      // Se a permissão ainda não foi concedida, solicite-a
      if (await Permission.photos.request().isGranted) {
        _pickImage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Elemento 1: Área de postagem
        Card(
          elevation: 2.0,
          margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'O que você está pensando?',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _getGalleryPermissionAndPickImage();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Post criado'),
                              content: Text('Seu post foi criado com sucesso!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/main');
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Elemento 2: Criar Partida
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormPartidaCreate()),
            );
          },
          child: Card(
            elevation: 60.0,
            margin: EdgeInsets.all(30.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/create_screen1.jpg',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.4,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Center(
                      child: Text(
                        'Criar Partida',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Elemento 3: Row - Ofertar Arena e Oferecer Serviços
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                // Adicionar logica par adireciona a tela de cadastro de evento
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormArenaCreate()),
                );
              },
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0), // Bordas arredondadas
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                          'assets/images/create_screen2.jpg',
                          width: MediaQuery.of(context).size.width * 0.37,
                          height: MediaQuery.of(context).size.width * 0.37,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Text(
                          'Ofertar Arena',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navegar para a página de oferecer serviços
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormServicoCreate()),
                );
              },
              child: Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12.0), // Bordas arredondadas
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                          'assets/images/create_screen3.jpg',
                          width: MediaQuery.of(context).size.width * 0.37,
                          height: MediaQuery.of(context).size.width * 0.37,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        child: Text(
                          'Oferecer Serviços',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
