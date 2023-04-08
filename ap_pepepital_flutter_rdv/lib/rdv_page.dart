import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
      body: const SizedBox(
        width: double.infinity,
        child: Text(
          "Listes des RDVs en cours",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
