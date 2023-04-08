import 'package:ap_pepepital_flutter_rdv/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ap_pepepital_flutter_rdv/main.dart' show MyApp;

class Profil extends StatelessWidget {
  const Profil({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
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
      // ignore: use_build_context_synchronously
      Navigator.of(context).removeRoute(ModalRoute.of(context) as Route);
    }

    return Center(
        child: ElevatedButton.icon(
      onPressed: () {
        _logout();
      },
      icon: const Icon(Icons.exit_to_app),
      label: const Text('Se déconnecter'),
    ));
  }
}
