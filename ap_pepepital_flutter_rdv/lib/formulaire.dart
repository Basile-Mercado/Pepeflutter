import 'dart:convert';
import 'package:flutter/foundation.dart' show Key, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);
  @override
  State<Formulaire> createState() => _FormulaireState();
}

final _formKey = GlobalKey<FormState>();

void login(String email, password) async {
  try {
    Response response = await post(
        Uri.parse("192.168.1.20:8000/api/login_check"),
        body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      if (kDebugMode) {
        print(data['token']);
      }
      if (kDebugMode) {
        'Connexion réussie';
      }
    } else {
      'Connexion échouée';
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Login',
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Formulaire(),
    ),
  );
}

class _FormulaireState extends State<Formulaire> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription/Connexion Pepepital'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                login(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text('Login')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
