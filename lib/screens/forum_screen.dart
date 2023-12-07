import 'package:flutter/material.dart';
///Implementa a tela de fóruns na aplicação. Pode exibir uma lista de fóruns temáticos disponíveis para os usuários participarem.
class ForumPage extends StatelessWidget {
  final String forumTitle;

  ForumPage({required this.forumTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(forumTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildTopicCard(context, 'Tópico 1', 'Descrição do Tópico 1'),
          _buildTopicCard(context, 'Tópico 2', 'Descrição do Tópico 2'),
          _buildTopicCard(context, 'Tópico 3', 'Descrição do Tópico 3'),
          // Adicione mais tópicos conforme necessário
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createNewTopic(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildTopicCard(
      BuildContext context, String title, String description) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          _navigateToTopicPage(context, title);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToTopicPage(BuildContext context, String topicTitle) {
    print('Navegar para a página do tópico: $topicTitle');
    // Implemente a navegação para a página do tópico aqui
  }

  void _createNewTopic(BuildContext context) {
    print('Criar novo tópico no fórum: $forumTitle');
    // Implemente a lógica para criar um novo tópico no fórum aqui
  }
}
