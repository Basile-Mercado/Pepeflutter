import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RDV extends StatefulWidget {
  const RDV({super.key});
  @override
  State<RDV> createState() => _RDVState();
}

Future<List<dynamic>> getRDV() async {
  //final token = getToken().toString();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final jwt = prefs.getString('token');
  List<dynamic> lesRDV = [];
  var response = await http.get(
      Uri.parse('https://192.168.1.42:8000/api/r_d_vs'),
      headers: <String, String>{
        'Authorization': 'Bearer $jwt',
      });
  if (response.statusCode == 200) {
    var rdv = await json.decode(response.body)['hydra:member'];
    for (var values in rdv) {
      lesRDV.add(values);
    }
    return lesRDV;
  } else {
    throw Exception('Erreur');
  }
}

class _RDVState extends State<RDV> {
  Future<List<dynamic>>? _rdv;

  @override
  void initState() {
    super.initState();
    _rdv = getRDV();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voir vos rendez-vous'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _rdv,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<dynamic> rdv = snapshot.data!;
            return ListView.builder(
              itemCount: rdv.length,
              itemBuilder: (context, index) {
                final rdvItem = rdv[index];
                return ListTile(
                  title: Text(
                      '${rdvItem['date']}${rdvItem['duree']} minutes${rdvItem['medecin']}'),
                  leading: CircleAvatar(
                    child: Text(rdvItem['initial'].toString()),
                  ),
                  onTap: () {},
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
