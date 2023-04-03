import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final ButtonStyle style = ElevatedButton.styleFrom(
      enableFeedback: true,
      fixedSize: const Size(250, 300),
    );
    return const Column(children: <Widget>[Text('Bienvenue !')]);
  }
}
