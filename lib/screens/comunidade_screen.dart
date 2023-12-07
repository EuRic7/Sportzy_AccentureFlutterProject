import 'package:flutter/material.dart';
import '/screens/matches.dart';
import 'findArenas.dart';
import 'findMatches.dart';
import 'findServices.dart';

///Este arquivo contém a implementação da tela principal da aplicação, denominada CommunityScreen. Ela exibe categorias relacionadas à comunidade esportiva, como fóruns temáticos, grupos e clubes, desafios e competições, reconhecimento e conquistas.
class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildCategoryCard(
            context,
            'Encontrar Partidas',
            'Encontre partidas para jogar',
            'assets/images/EncontrarPartidas.png',
            'Escolha uma partida com vagas disponíveis e confirme ' +
                'que estará presente no local na hora marcada. ',
          ),
          _buildCategoryCard(
            context,
            'Encontrar Arenas',
            'Descubra locais para jogar',
            'assets/images/Arena.png',
            'Arenas são espaços para realização de esporte' +
                'nesta área você pode alugar uma arena no horário disponível' +
                ' para  jogar com seu time.',
          ),
          _buildCategoryCard(
            context,
            'Encontrar Parceiros',
            'Conecte-se com outros jogadores',
            'assets/images/Parceiros.png',
            'Você está precisando de alguém no seu time?' +
                ' Nesta área você encontra profissionais e amadores' +
                'dispostos a participarem de sua partida para exercer diversas funções',
          ),
          _buildCategoryCard(
            context,
            'Suas Partidas',
            'Veja suas partidas agendadas',
            'assets/images/MinhasPartidas.png',
            'Aqui você faz o checkin das suas partidas agendadas e ver o seu histórico de partidas',
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String description,
    String imageUrl,
    String infoDoCard,
  ) {
    return GestureDetector(
      onTap: () {
        _navigateToCategoryPage(context, title);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200.0, // Customize the height as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    _showInfoDialog(context, infoDoCard);
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategoryPage(BuildContext context, String category) {
    // Implement your navigation logic here
    switch (category) {
      case 'Encontrar Partidas':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindMatches()),
        );
        break;
      case 'Encontrar Arenas':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindArenas()),
        );
        break;
      case 'Encontrar Parceiros':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindServices()),
        );
        break;
      case 'Suas Partidas':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyMatches()),
        );
        break;
      default:
        print('Categoria não reconhecida: $category');
    }
  }

  void _showInfoDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Informação'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
