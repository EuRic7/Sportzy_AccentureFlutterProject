import 'package:flutter/material.dart';

class FindArenas extends StatefulWidget {
  @override
  _FindArenasState createState() => _FindArenasState();
}
///Esses arquivos podem conter implementações específicas para encontrar arenas, partidas e serviços na aplicação. Cada um deles pode fornecer uma interface para os usuários pesquisarem e descobrirem elementos específicos da comunidade esportiva.
class _FindArenasState extends State<FindArenas> {
  String selectedTime = '14:00'; // Valor inicial do horário
  List<String> availableTimes = ['14:00', '16:00', '18:00', '20:00'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encontrar Arenas'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildArenaCard(
            context,
            'Piscina Esportiva',
            4.7, // Reputação do usuário em estrelas
            'Piscina da UFPE',
            'R\$ 100,00', // Custo do aluguel
            'assets/images/arena_pscina5.jpg',
          ),
          _buildArenaCard(
            context,
            'Quadra de Futsal',
            4.5, // Reputação do usuário em estrelas
            'Av. S.Matheus N°33 Iputinga',
            'R\$ 80,00', // Custo do aluguel
            'assets/images/arena_futsal.jpeg',
          ),
          _buildArenaCard(
            context,
            'Quadra de Tênis',
            4.2, // Reputação do usuário em estrelas
            '',
            'R\$ 120,00', // Custo do aluguel
            'assets/images/arena_tênis.jpg',
          ),
          _buildArenaCard(
            context,
            'Quadra de Basquete',
            4.8, // Reputação do usuário em estrelas
            'Parque do Caiara, Iputinga',
            'R\$ 90,00', // Custo do aluguel
            'assets/images/arena_basquete.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildArenaCard(
    BuildContext context,
    String title,
    double reputation,
    String address,
    String rentalCost,
    String imagePath,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20.0),
                      Text(
                        '$reputation',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Endereço: $address',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Custo do Aluguel: $rentalCost',
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

  void _showConfirmationDialog(BuildContext context, String arenaName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text('Reservar Arena'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Escolha um horário disponível:'),
                  SizedBox(height: 8.0),
                  DropdownButton<String>(
                    value: selectedTime,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTime = newValue!;
                      });
                    },
                    items: availableTimes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Implemente aqui a lógica para confirmar a reserva
                          Navigator.of(context).pop();
                          _showConfirmationSuccessDialog(context);
                        },
                        child: Text('Confirmar'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showConfirmationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmado! O seu código é 777321'),
          content: Column(
            children: [
              Text('não compartilhe o seu código com outras pessoas'),
              SizedBox(height: 16.0),
              Image.asset(
                'assets/images/Parceiros.png',
                height: 100.0,
              ),
              SizedBox(height: 16.0),
              Icon(
                Icons.check,
                color: Colors.green,
                size: 48.0,
              ),
            ],
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

void main() {
  runApp(MaterialApp(
    home: FindArenas(),
  ));
}
