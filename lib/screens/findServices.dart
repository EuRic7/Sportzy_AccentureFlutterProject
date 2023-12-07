import 'package:flutter/material.dart';

class FindServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encontrar Serviços'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildServiceCard(
            context,
            'Árbitro de Voley',
            'John Doe', // Nome da pessoa oferecendo o serviço
            4.5, // Reputação do usuário em estrelas
            'Região 1', // Região em que o serviço é ofertado
            'R\$ 50,00', // Custo do serviço
            'assets/images/servico_arbitro.jpg', // Imagem do diretório /assets/image/
          ),
          _buildServiceCard(
            context,
            'Goleiro',
            'Jane Doe', // Nome da pessoa oferecendo o serviço
            4.2, // Reputação do usuário em estrelas
            'Região 2', // Região em que o serviço é ofertado
            'R\$ 40,00', // Custo do serviço
            'assets/images/servico_goleiro.jpg', // Imagem do diretório /assets/image/
          ),
          _buildServiceCard(
            context,
            'Gandula',
            'Fernanda Smith', // Nome da pessoa oferecendo o serviço
            3.8, // Reputação do usuário em estrelas
            'Região 3', // Região em que o serviço é ofertado
            'R\$ 30,00', // Custo do serviço
            'assets/images/servico_gandula.png', // Imagem do diretório /assets/image/
          ),
          _buildServiceCard(
            context,
            'Bandeirinha',
            'Alice Johnson', // Nome da pessoa oferecendo o serviço
            4.0, // Reputação do usuário em estrelas
            'Região 4', // Região em que o serviço é ofertado
            'R\$ 35,00', // Custo do serviço
            'assets/images/servico_bandeiinha.jpg', // Imagem do diretório /assets/image/
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    String providerName,
    double reputation,
    String region,
    String cost,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        _showConfirmationDialog(context, title, providerName);
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
                    'Oferecido por: $providerName',
                    style: TextStyle(
                      fontSize: 16.0,
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
                    'Região: $region',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Custo: $cost',
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

  void _showConfirmationDialog(
      BuildContext context, String serviceName, String providerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contratar Serviço'),
          content: Text(
              'Deseja contratar o serviço de "$serviceName" oferecido por $providerName?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Implemente aqui a lógica para confirmar a contratação
                Navigator.of(context).pop();
                _showConfirmationSuccessDialog(context, providerName);
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationSuccessDialog(
      BuildContext context, String providerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contratação Confirmada'),
          content: Text('$providerName entrará em contato em breve.'),
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
    home: FindServices(),
  ));
}
