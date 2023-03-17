import 'dart:convert';
import 'dart:math';
import 'package:ap_pepepital_flutter_rdv/home_page.dart';
import 'package:ap_pepepital_flutter_rdv/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);
  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Map<String, dynamic> user = new Map();
  bool recupLogin = false;

  // Fonction pour la connexion et récupération du JWT Token
  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.20:8000/api/login_check'),
      headers: {
        'Content-Type': 'aplication/json',
      },
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text
      }),
    );
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      final payload = token.split('.')[1];
      recupLogin = true;
    } else {
      "Erreur de connexion";
    }
  }

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
                if (value?.isEmpty == null) {
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
                if (value?.isEmpty == null) {
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
                  if (_formKey.currentState?.validate() == null) {
                    login(emailController.text, passwordController.text);
                  }
                },
                child: const Text("Se connecter"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
