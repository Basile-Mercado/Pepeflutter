import 'dart:convert';
import 'package:flutter/foundation.dart' show Key, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);
  @override
  State<Formulaire> createState() => _FormulaireState();
}

final _formKey = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

Future<void> login() async {
  final response = await http.post(
    Uri.parse('http://192.168.1.20:8000/api/login_check'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': emailController.text,
      'password': passwordController.text,
    }),
  );
  if (response.statusCode == 200) {
    final token = jsonDecode(response.body)['token'];
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    // Navigate to the home page.
  } else {
    // Show an error message.
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
              validator: (value) {
                if (value!.isNotEmpty) {
                  return 'Veuillez saisir votre adresse mail';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Mot de Passe'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer un mot de passe';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  login();
                },
                child: const Text("Se connecter")
              ),
            )
          ],
        ),
      ),
    );
  }
}
