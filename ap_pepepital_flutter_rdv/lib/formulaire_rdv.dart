
import 'dart:convert' as convert;
import 'package:ap_pepepital_flutter_rdv/medecin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


List<String> list = <String>['Medecin 1', 'Medecin 2', 'Medecin 3', 'Medecin 4'];

class FormulaireRdv extends StatelessWidget {
  const FormulaireRdv({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Prendre rendez-vous')),
        body: const Center(
          child: DropdownButtonExample(),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _FormulaireRdvState();
}

class _FormulaireRdvState extends State<DropdownButtonExample> {
  
  Future<List> medecins = getMedecins();

  @override
  Widget build(BuildContext context) {
    getMedecins();
    String dropdownValue = medecins[];
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  Future<List> getMedecins() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await http.get(
      Uri.parse('http://192.168.1.20:8000/api/medecins'),
      headers: {
        'Authorization':
          'Bearer $token'
      },
    );
    Map<String, dynamic> map = convert.jsonDecode(response.body);
    medecins = map["hydra:member"].toList();
    setState(() {
      medecins;
    });
    return medecins;
  }
}
