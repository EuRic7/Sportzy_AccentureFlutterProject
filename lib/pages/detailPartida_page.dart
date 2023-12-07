import 'dart:io';

import 'package:flutter/material.dart';
///Implementa a página de detalhes de uma partida específica. Essa página pode exibir informações sobre a partida, como equipes envolvidas, horário, local e outros detalhes relevantes.
class DetalhesPartidaPage extends StatelessWidget {
  final String nomeEvento;
  final String descricaoEvento;
  final File imagemEvento;
  final String rua;
  final String bairro;
  final String cidade;
  final bool presencialEvento;

  DetalhesPartidaPage(
      {required this.nomeEvento,
      required this.descricaoEvento,
      required this.presencialEvento,
      required this.imagemEvento,
      required this.rua,
      required this.cidade,
      required this.bairro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Evento'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: FileImage(imagemEvento),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0), // Espaçamento entre a imagem e o texto
            Text(
              'Nome do Evento:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              nomeEvento,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Descrição do Evento:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              descricaoEvento,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Presencial:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              presencialEvento ? 'Sim' : 'Não',
              style: TextStyle(fontSize: 16.0),
            ),
            Spacer(),
            Text(
              'Endereço:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              rua,
              style: TextStyle(fontSize: 16.0),
            ),
            Spacer(),
            Text(
              bairro,
              style: TextStyle(fontSize: 16.0),
            ),
            Spacer(),
            Text(
              cidade,
              style: TextStyle(fontSize: 16.0),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Voltar para inicio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
