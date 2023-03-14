import 'package:flutter/foundation.dart' show Key, kDebugMode;
import 'package:flutter/material.dart'
    show
        Alignment,
        AppBar,
        BuildContext,
        Colors,
        Container,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        InputDecoration,
        Key,
        ListView,
        MaterialApp,
        OutlineInputBorder,
        Padding,
        Row,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextEditingController,
        TextField,
        TextStyle,
        Widget;

class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);
  @override
  State<Formulaire> createState() => _FormulaireState();
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_new
    return new Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                "Pepepital",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Se Connecter',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mail/Login',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de Passe',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //redirigé pour l'oubli de mot de passe
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () {
                  if (kDebugMode) {
                    print(nameController.text);
                  }
                  if (kDebugMode) {
                    print(passwordController.text);
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Vous n\'avez pas de compte ?'),
                TextButton(
                  child: const Text(
                    'S\'inscrire',
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    //rediriger sur creation de compte
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
