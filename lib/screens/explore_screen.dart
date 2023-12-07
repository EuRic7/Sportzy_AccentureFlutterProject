import 'package:flutter/material.dart';
import 'package:Sportzy/pages/perfil_page.dart';
/// Implementa a tela de exploração (Explore) da aplicação. Essa tela pode permitir que os usuários descubram novas arenas, partidas, serviços e outras atividades relacionadas à comunidade esportiva.
class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          // Atribuir imagens e descrições postagem
          String profileImage;
          String postImage;
          String description;
          String username;
          //person_tiffani.jpeg  person_stef.jpeg person_sandra.jpeg
          //person_ray.jpeg person_manda.png person_kevin.jpeg
          switch (index) {
            case 0:
              profileImage = 'assets/profile_pics/person_tiffani.jpeg';
              postImage =
                  'https://th.bing.com/th/id/OIP.CqzUsGwt2s1Ov3vHCo5qFwHaFj?rs=1&pid=ImgDetMain';
              description = 'adorei a partida de voley com a galera hoje!';
              username = 'Tiffani Almeida';
              break;
            case 1:
              profileImage = 'assets/profile_pics/person_cesare.jpeg';
              postImage =
                  'https://th.bing.com/th/id/OIP.T-dDrn0gbpDq8SFaaE5PBwHaE7?w=264&h=180&c=7&r=0&o=5&pid=1.7';
              description = 'Pedalando pela vida: Liberdade sobre duas rodas!' +
                  ' #AmoPedalar #VidaAtiva';
              username = 'Dino Maia';
              break;

            case 2:
              profileImage = 'assets/profile_pics/person_crispy.png';
              postImage =
                  'https://th.bing.com/th/id/OIP.GLrZXdg0KVpxjMe8tye4jAHaE8?w=301&h=201&c=7&r=0&o=5&pid=1.7';
              description = 'Na quadra e no coração: a paixão pelo futsal' +
                  ' não tem limites! ⚽️💪 #FutsalLovers #VivaOFutsal';
              username = 'Fernando Silva ';
              break;
            case 3:
              profileImage = 'assets/profile_pics/person_katz.jpeg';
              postImage =
                  'https://th.bing.com/th/id/OIP.lp35DysVC994vKUfXKIo9QHaE1?w=300&h=197&c=7&r=0&o=5&pid=1.7';
              description =
                  'Campeonato realizado ontem + diversão com os amigos.';
              username = 'Katz Almeida';
              break;
            case 4:
              profileImage = 'assets/profile_pics/person_kevin.jpeg';
              postImage =
                  'https://th.bing.com/th/id/R.459d10b64fa8adc8f4d22b2c7455a671?rik=PfaUEqZ1Hnhgzg&pid=ImgRaw&r=0';
              description = 'caminhada intensa, percurso realizado com sucesso';
              username = 'Ciro Romero';
              break;

            case 5:
              profileImage = 'assets/profile_pics/person_stef.jpeg';
              postImage =
                  'https://th.bing.com/th/id/R.000b0859518645353b9840c780ac57b4?rik=a98aNWBdF5iYNA&riu=http%3a%2f%2f1.bp.blogspot.com%2f-iYKf3T5OhaQ%2fTkQdqBy8hrI%2fAAAAAAAAACg%2f_TtOc8oZJ_E%2fs1600%2fnatacao-.png&ehk=vrEafAjh%2b9Xt7FzzH9iFsFRa7TKseHo390AYsyBqXU8%3d&risl=&pid=ImgRaw&r=0';
              description = 'Natação é a minha paixão. Feliz por encontrar' +
                  'um grupo que me proporcionou voltar a nadar';
              username = 'Stef';
              break;
            // Adicione mais casos conforme necessário

            default:
              profileImage = 'assets/profile_pics/default_profile.png';
              postImage =
                  'https://th.bing.com/th/id/OIP.DC1hBV48Vz3CqMGzmxSljgHaE7?w=244&h=180&c=7&r=0&o=5&pid=1.7';
              description = 'Sportzy Profille';
              username = 'Default7';
          }

          return PostCard(
            index: index,
            profileImage: profileImage,
            postImage: postImage,
            description: description,
            username: username,
            nome: username,
            image: postImage,
          );
        },
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final String nome;
  final String image;
  final int index;
  final String profileImage;
  final String postImage;
  final String description;
  final String username;

  const PostCard({
    Key? key,
    required this.index,
    required this.profileImage,
    required this.postImage,
    required this.description,
    required this.username,
    required this.nome,
    required this.image,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List<String> comments = [];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Adição de foto de perfil e nome de usuário
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PerfilPage(nome: widget.nome, image: widget.profileImage),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.profileImage),
            ),
            title: Text(widget.username),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              widget.postImage,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // colocar descrição
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Comentários:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                SizedBox(height: 4.0),
                // Adicione os comentários existentes
                for (String comment in comments)
                  CommentWidget(
                    comment: comment,
                    profileImage: widget.profileImage,
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CommentForm(
              onCommentAdded: (comment) {
                setState(() {
                  comments.add(comment);
                });
              },
              profileImage: widget.profileImage,
            ),
          ),
        ],
      ),
    ));
  }
}

class CommentWidget extends StatelessWidget {
  final String comment;
  final String profileImage;

  const CommentWidget({
    Key? key,
    required this.comment,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_pics/person_manda.png'),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(comment),
          ),
        ],
      ),
    );
  }
}

class CommentForm extends StatelessWidget {
  final Function(String) onCommentAdded;
  final String profileImage;

  const CommentForm({
    Key? key,
    required this.onCommentAdded,
    required this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();

    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/profile_pics/person_manda.png'),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Adicione um comentário...'),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () {
            if (commentController.text.isNotEmpty) {
              onCommentAdded(commentController.text);
              commentController.clear();
            }
          },
        ),
      ],
    );
  }
}
//person_tiffani.jpeg  person_stef.jpeg person_sandra.jpeg
//person_ray.jpeg person_manda.png person_kevin.jpeg
