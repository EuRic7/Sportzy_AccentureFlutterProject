import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Sportzy/pages/perfil_page.dart';
import 'package:Sportzy/screens/create_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Sportzy/firebase_options.dart';

//import 'package:login/pages/createContent_page.dart';
import 'fooderlich_theme.dart';
import '/screens/explore_screen.dart';
import '/screens/comunidade_screen.dart';

FirebaseAnalytics? analytics;

FirebaseAnalyticsObserver? observer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    await FirebaseAuth.instanceFor(app: app).setPersistence(Persistence.LOCAL);
  }
  analytics = FirebaseAnalytics.instanceFor(app: app);
  runApp(Fooderlich());
}

class Fooderlich extends StatefulWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  _FooderlichState createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  int _currentIndex = 0; // Track the current selected index

  static List<Widget> pages = <Widget>[
    FeedScreen(),
    CreatePostContent(),
    CommunityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void _showPopupMenu(BuildContext context) async {
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;

      await showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          overlay.size.width - 40.0,
          kToolbarHeight,
          overlay.size.width,
          kToolbarHeight + 40.0,
        ),
        items: [
          PopupMenuItem<String>(
            value: 'light',
            child: const Text('Tela Clássica'),
          ),
          PopupMenuItem<String>(
            value: 'dark',
            child: const Text('Tela Escura'),
          ),
        ],
      ).then((value) {
        if (value == 'dark') {
          setState(() {
            tema = FooderlichTheme.dark();
          });
        } else if (value == 'light') {
          setState(() {
            tema = FooderlichTheme.light();
          });
        }
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema,
      title: 'Fooderlich',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sportzy', style: TextStyle(fontSize: 30)),
          centerTitle: true,
          leading: Container(
            width: 58,
            child: PopupMenuButton<String>(
              onSelected: (String value) {
                if (value == '1') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PerfilPage(
                              nome: 'Manda Cardoso',
                              image: "assets/profile_pics/person_manda.png",
                            )),
                  );
                }
              },
              icon: CircleAvatar(
                backgroundImage:
                    AssetImage('assets/profile_pics/person_manda.png'),
              ),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: '1',
                  child: Text('Perfil'),
                ),
                // Outros itens do menu, se houver
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.palette_outlined),
              onPressed: () {
                _showPopupMenu(context);
              },
            ),
          ],
        ),
        body: IndexedStack(children: pages, index: _currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: _currentIndex, // Set the current selected index
          onTap: (index) {
            // Update the current index when a menu item is tapped
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add),
              label: 'Criar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Comunidade',
            ),
          ],
        ),
      ),
    );
  }

  _logout() {
    FirebaseAuth.instance.signOut().then((result) {
      Navigator.of(context).pushNamedAndRemoveUntil("/login", (_) => false);
    });
  }
}
