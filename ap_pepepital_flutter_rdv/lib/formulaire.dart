import 'package:flutter/material.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({super.key});

  @override
  State<Formulaire> createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.mail),
              hintText: 'Quel est votre login ?',
              labelText: 'Login: ',
            ),
            validator: (value) {
              return null;
            },
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Processing Data"),
                  ),
                );
              }
              child:
              const Text("Submit");
            },
            icon: const Icon(Icons.check),
            label: const Text("S'inscrire/Se connecter"),
          )
        ],
      ),
    );
  }
}
