import 'package:flutter/material.dart';

class MyMatches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suas Partidas'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildScheduledMatchCard(context),
          _buildTrophyIcons(),
          _buildMatchHistoryCard(
              context,
              'Natação Campeonato',
              'UFPE',
              'Recife',
              'Várzea',
              true,
              'Venceu',
              'assets/images/piscinaUFPE.jpg'),
          _buildMatchHistoryCard(
              context,
              'Jogo de Basket',
              'Parque do Caiara',
              'Recife',
              'Iputinga',
              false,
              'Sem Trofeus',
              'assets/images/QuadraCaiara.jpg'),
          _buildMatchHistoryCard(
              context,
              'Torneio Futebol',
              'Campo do 13',
              'Recife',
              'Arruda',
              true,
              'Sem Trofeus',
              'assets/images/partidajogada.png'),
          _buildMatchHistoryCard(
              context,
              'Jogo das Meninas',
              'Espaço Esporte',
              'Recife',
              'Boa Viagem',
              false,
              'Evento Concluído',
              'assets/images/footbolfeminino.png'),
        ],
      ),
    );
  }

  Widget _buildTrophyIcons() {
    // You may replace this with the logic to fetch and display user's trophy count
    return Row(
      children: [
        Icon(Icons.emoji_events, color: Colors.yellow),
        Text('+1'),
        // Gold Trophy
        // Silver Trophy
      ],
    );
  }

  Widget _buildScheduledMatchCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCheckInDialog(context);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/eventoagendado.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share_location, size: 80),
                      onPressed: () {
                        _showCheckInDialog(context);
                      },
                    ),
                    Text(
                      'Fazer check-in',
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Localização: Nome do local, Cidade, Bairro',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Presença: Aguardando Check-in',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Resultado: Pendente',
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

  Widget _buildMatchHistoryCard(
    BuildContext context,
    String title,
    String location,
    String city,
    String district,
    bool attended,
    String result,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        _navigateToGalleryPage(context, title);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
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
                    'Localização: $location, $city, $district',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Presença: ${attended ? 'Compareceu' : 'Não Compareceu'}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Resultado: $result',
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

  void _navigateToGalleryPage(BuildContext context, String matchName) {
    // Implement your navigation to the gallery page
    print('Navigating to Gallery Page for $matchName');
  }

  void _showCheckInDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Check-in'),
          content: Text('Você deseja fazer check-in na partida agendada?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Implement your logic for check-in
                Navigator.of(context).pop();
                _showCheckInSuccessDialog(context);
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showCheckInSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Check-in Concluído'),
          content:
              Icon(Icons.check_circle_outline, color: Colors.green, size: 70),
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

void main() {
  runApp(MaterialApp(
    home: MyMatches(),
  ));
}
