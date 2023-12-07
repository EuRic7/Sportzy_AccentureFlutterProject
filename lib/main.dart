import 'dart:async';

import 'package:Sportzy/pages/detailArena_page.dart';
import 'package:Sportzy/pages/fooderlich_theme.dart';
import 'package:Sportzy/pages/formServicoCreate.dart';
import 'package:Sportzy/screens/comunidade_screen.dart';
import 'package:Sportzy/screens/findMatches.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Sportzy/firebase_options.dart';
import 'package:Sportzy/pages/perfil_page.dart';

import 'pages/login_page.dart';
import 'pages/main_page.dart';
import 'pages/splash_page.dart';
import 'pages/register_page.dart';

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
  runApp(MyApp());
}

//const mainColor = Color(0xff00BF63);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: tema,
      title: 'Simple Login App',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics!),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/main': (context) => Fooderlich(),
        '/register': (context) => RegisterPage(),
        '/perfil': (context) => PerfilPage(),
        '/partidas': (context) => FindMatches(),
      },
    );
  }
}
