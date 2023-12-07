import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage();

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer(Duration(seconds: 2), () {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil('/main', (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                //adicionando imagem da spleenScreen
                image: AssetImage('assets/icons/Sport.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
