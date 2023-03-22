import 'dart:convert';
import 'package:http/http.dart' as http;

class MonAPI {
  final String apiUrl = 'http://192.168.1.22:8000/api';

  Future<List<dynamic>> getMedecins() async {
    //final prefs = await SharedPreferences.getInstance();
    //final token = prefs.getString('jwtToken');
    final response = await http.get(
      Uri.parse('$apiUrl/sejours'),
      headers: {
        'Authorization':
            'Bearer REDACTED'
      },
    );

    if (response.statusCode == 200) {
      var test = json.decode(response.body)['hydra:member'];
      return test;
    } else {
      throw Exception('Failed to load medecins');
    }
  }
}

class Medecin {
  final int id;
  final String name;
  final String speciality;

  Medecin({required this.id, required this.name, required this.speciality});

  factory Medecin.fromJson(Map<String, dynamic> json) {
    return Medecin(
      id: json['id'],
      name: json['name'],
      speciality: json['speciality'],
    );
  }
}
