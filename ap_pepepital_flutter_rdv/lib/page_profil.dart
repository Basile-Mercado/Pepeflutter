import 'package:ap_pepepital_flutter_rdv/formulaire.dart';
import 'package:ap_pepepital_flutter_rdv/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> getLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('token');
      if (jwt == null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Formulaire();
            },
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const MyApp();
            },
          ),
        );
      }
    }

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
          getLogin();
        },
        icon: const Icon(Icons.create),
        label: const Text("S'inscrire/Se connecter"),
      ),
    );
  }
}
