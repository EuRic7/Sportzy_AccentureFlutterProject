import 'package:flutter/material.dart';

class FindMatches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encontrar Partidas'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildMatchCard(
            context,
            'Volei Aquático',
            'Presencial',
            'Clube de Pscinas Casa Amarela',
            true, // Vale Troféu
            20, // Quantidade de Vagas
            'assets/images/partida_voleypscina.jpg',
            '14:00', // Horário
            'R\$ 20,00', // Preço
          ),
          _buildMatchCard(
            context,
            'Corrida Virtual c/ Rota GPS',
            'Virtual',
            'Partida Online',
            false, // Não vale Troféu
            20, // Quantidade de Vagas
            'assets/images/partida_corrida.jpg',
            '16:15', // Horário
            'Gratuito', // Preço
          ),
          _buildMatchCard(
            context,
            'Partida de Futsal',
            'Presencial',
            'Parque de Camaragibe',
            true, // Vale Troféu
            15, // Quantidade de Vagas
            'assets/images/partida_futsal.jpg',
            '18:00', // Horário
            'Gratuito', // Preço
          ),
          _buildMatchCard(
            context,
            'Corrida Virtual na Esteira',
            'Virtual',
            'Partida Online',
            false, // Não vale Troféu
            25, // Quantidade de Vagas
            'assets/images/partida_corrida2.jpg',
            '20:00', // Horário
            'Gratuito', // Preço
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(
    BuildContext context,
    String title,
    String matchType,
    String locationInfo,
    bool hasTrophy,
    int availableSlots,
    String imagePath,
    String time,
    String price,
  ) {
    return GestureDetector(
      onTap: () {
        _showConfirmationDialog(context, title);
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
                    'Tipo da Partida: $matchType',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    matchType == 'Presencial'
                        ? 'Endereço: $locationInfo'
                        : 'Informação: $locationInfo',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Vale Troféu: ${hasTrophy ? 'Sim' : 'Nao'}',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Vagas Disponíveis: $availableSlots',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Horário: $time',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Preço: $price',
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

  void _showConfirmationDialog(BuildContext context, String matchName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Agendamento'),
          content:
              Text('Deseja confirmar o agendamento da partida "$matchName"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Implemente aqui a lógica para confirmar o agendamento
                Navigator.of(context).pop();
                _showConfirmationSuccessDialog(context);
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agendamento Confirmado. O seu código é: 777294'),
          content: Icon(
            Icons.check,
            color: Colors.green,
            size: 50,
          ),
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
