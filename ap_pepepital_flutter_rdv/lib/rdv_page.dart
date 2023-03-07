import 'package:flutter/material.dart';

class RDV extends StatefulWidget {
  const RDV({super.key});
  @override
  State<RDV> createState() => _RDVState();
}

class _RDVState extends State<RDV> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pepepital"),
      ),
      body: Container(
        width: double.infinity,
        child: const Text(
          "Listes des RDVs en cours",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
