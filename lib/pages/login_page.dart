import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../appbar.dart';
import '../input.dart';
import '../scrollable_column.dart';
///Contém a implementação da tela de login da aplicação. Pode incluir campos para inserir credenciais de usuário, como e-mail e senha.

class LoginPage extends StatefulWidget {
  const LoginPage() : super();
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/profile_pics/login_background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/Logo.png',
                        fit: BoxFit.contain,
                        width: 200,
                        height: 200,
                      ),
                      CustomInputField(
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Email",
                        controller: _emailController,
                        validator: (String? email) {
                          if (email == null) {
                            return null;
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email);
                          return emailValid ? null : "Email é inválido";
                        },
                      ),
                      SizedBox(height: 24),
                      CustomInputField(
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Senha",
                        obscureText: true,
                        controller: _passwordController,
                        validator: (String? password) {
                          if (password == null) {
                            return null;
                          }
                          if (password.length < 6) {
                            return "Senha muito curta, precisa ter mais que 6 caracteres";
                          }
                        },
                      ),
                      SizedBox(height: 24),
                      CustomCheckbox(
                        labelText: "Lembre-me",
                        value: _rememberMeChecked,
                        onChanged: (checked) => setState(
                            () => _rememberMeChecked = checked ?? false),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        child: Text("Entrar"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: _emailController.value.text,
                              password: _passwordController.value.text,
                            )
                                .then((result) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/main', (_) => false);
                            }).catchError((Object exception) {
                              if (exception is FirebaseAuthException) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Falha na autenticação: ${exception.message}')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Erro de autenticação não tratado: ${exception}')),
                                );
                              }
                            });
                          }
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextButton(
                            child: Text("Registrar"),
                            onPressed: () =>
                                {Navigator.of(context).pushNamed("/register")},
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
