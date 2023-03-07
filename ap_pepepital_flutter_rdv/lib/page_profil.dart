import 'package:ap_pepepital_flutter_rdv/formulaire.dart';
import 'package:ap_pepepital_flutter_rdv/rdv_page.dart';
import 'package:flutter/material.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      enableFeedback: true,
      fixedSize: const Size(255, 30),
    );
    return Center(
      heightFactor: double.infinity,
      widthFactor: double.infinity,
      child: ElevatedButton.icon(
        style: style,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Formulaire();
              },
            ),
          );
        },
        icon: const Icon(Icons.create),
        label: const Text("S'inscrire/Se connecter"),
      ),
    );
  }
}
