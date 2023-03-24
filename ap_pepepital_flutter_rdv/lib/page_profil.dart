import 'package:ap_pepepital_flutter_rdv/formulaire.dart';
import 'package:ap_pepepital_flutter_rdv/home_page.dart';
import 'package:ap_pepepital_flutter_rdv/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    void _logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const MyApp();
          },
        ),
      );
    }

    return Column(
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: () {
            _logout();
          },
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Se déconnecter'),
        )
      ],
    );
  }
}
