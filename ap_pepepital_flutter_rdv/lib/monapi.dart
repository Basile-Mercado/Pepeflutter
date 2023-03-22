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
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2Nzg5Nzc0MzEsImV4cCI6MTY3ODk4MTAzMSwicm9sZXMiOlsiUk9MRV9VU0VSIl0sInVzZXJuYW1lIjoiYmFzaWxlQGdtYWlsLmNvbSJ9.Nm-qkzF_vtEYgTCn6j3zbRXAy8fn_jkzl82TolDjsV4K50PrfisylCz9tddyTY5WCtL0rh9iZioQ0bf2_znyiSRbGeJ7Pph0lB5pPBHZui3p4A-eqyy6ISLt3cv03xgE3i_BWa9C6_SqX9w6_KP3WNzJwdJSDqRS1I7-IEGkaO9jiVUCiqZVxvC5Fe6na3vrkWDaCd4s0o-_7qgya2E-F8FQVWaqqygwgeepjHLUtxV808cWEC8Nopl51Nkiil7Zoz_iKlc3K0EdqTEM8sOK0FXHBhQilsD2jkPoKVTgqCBwLykh3VwForjjRQ1u9w42T00PYAZdXIIiSEPTubop4A'
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
