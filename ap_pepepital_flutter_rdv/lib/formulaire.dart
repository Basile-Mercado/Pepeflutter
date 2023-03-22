// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:ap_pepepital_flutter_rdv/home_page.dart';
import 'package:ap_pepepital_flutter_rdv/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);
  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool recupLogin = false;
  String error = "oijkç_k";

  // Fonction pour la connexion et récupération du JWT Token
  Future<void> login(String email, String password) async {
    print(emailController.text);
    print(passwordController.text);
    final response = await http.post(
      Uri.parse('http://192.168.1.20:8000/api/login_check'),
      headers: {
        'Content-Type': 'application/json',
        //'location': 'https://192.168.1.20:8000/api/login_check'
      },
      body: jsonEncode({
        'username': emailController.text,
        'password': passwordController.text
      }),
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() {
        error = "test";
      });
      final token = jsonDecode(response.body)['token'];
      //const String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2Nzk0MDY1MjgsImV4cCI6MTY3OTQxMDEyOCwicm9sZXMiOlsiUk9MRV9QQVRJRU5UIiwiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoicGF0aWVudCJ9.WFHfJmcXh_FzMld4lBfk8lS2gHWx8GDE4EnEI-RXufvs8GAHR5IqyZlP8bZfGbKK0LWTCqs24_4iXZWRAzmal6pAiUwh_f4ynYVgKL653kVbJM6pOV66jCoqWpMH2vbucn3M1adfeqXOLMTYF2AatJe7j36RanlO9zYRGWCmNxgyneAJIJ28yVHODl9YLvsE92U2NhntUEbWqBb0adhliaKiIZobNm0LO2PZnVMcPGexy0ltTO7SN8u7S0diBlNnxe88hMILxMu4DUv1DnRacrczng46o-8OZ9xsOi-T5CY1OffZw0KXjrXfduUNCwb9UNdA9XCEd0itRCU-3-h3oQ";
      final payload = token.split('.')[1];
      final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
      final List roles = jsonDecode(decoded)["roles"];
      if (roles.contains("ROLE_PATIENT")) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        recupLogin = true;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const MyApp();
            },
          ),
        );
      } else {
        setState(() {
          error = 'Erreur de connexion [Rôle]';
        });
      }
    } else {
      setState(() {
        error = response.statusCode.toString();
      });
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
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Mot de Passe'),
            ),
            Text('$error'),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  login(emailController.text, passwordController.text);
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
