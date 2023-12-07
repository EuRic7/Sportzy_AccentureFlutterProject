import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../appbar.dart';
import '../input.dart';
import '../scrollable_column.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage() : super();
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _agreeWithTermsAndConditions = false;

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
              child: ScrollableColumn(
                children: [
                  Image.asset(
                    'assets/images/Logo.png',
                    fit: BoxFit.contain,
                    width: 150,
                    height: 150,
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
                      return emailValid ? null : "Email is not valid";
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
                        return "A senha é muito curta";
                      }
                    },
                  ),
                  SizedBox(height: 24),
                  CustomInputField(
                    keyboardType: TextInputType.visiblePassword,
                    hintText: "Confirmação de senha",
                    obscureText: true,
                    controller: _passwordConfirmationController,
                    validator: (String? password) {
                      if (password == null) {
                        return null;
                      }
                      if (password !=
                          _passwordConfirmationController.value.text) {
                        return "A senha não está confirmada";
                      }
                    },
                  ),
                  SizedBox(height: 24),
                  CustomCheckbox(
                    label: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "Ao criar uma conta,você concorda com a nossa",
                            style: TextStyle(
                              color: Color(0xFFa8a8a7),
                            ),
                          ),
                        ),
                        TextButton(
                          child: Text('Termos e Condições'),
                          onPressed: () {
                            print("// Terms & Conditions");
                          },
                        ),
                      ],
                    ),
                    value: _agreeWithTermsAndConditions,
                    onChanged: (checked) => setState(
                        () => _agreeWithTermsAndConditions = checked ?? false),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    child: Text("Registrar"),
                    onPressed: !_agreeWithTermsAndConditions
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _emailController.value.text,
                                password: _passwordController.value.text,
                              )
                                  .then((result) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/login', (_) => false);
                              }).catchError((Object exception) {
                                if (exception is FirebaseAuthException) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Failed to register: ${exception.message}')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Unhandled register error ${exception}')),
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
                        child: Text("Login"),
                        onPressed: () =>
                            {Navigator.of(context).pushNamed("/login")},
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
