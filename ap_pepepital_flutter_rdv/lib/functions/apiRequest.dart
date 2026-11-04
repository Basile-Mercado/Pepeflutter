// ignore: file_names
import 'dart:convert' as convert;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

Future<List> getLesRdvs() async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['API_URL'];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  List<dynamic> request = [];
  if (token != null) {
    final response = await http.get(
      Uri.parse('$apiUrl/api/r_d_vs'),
      headers: {'Authorization': 'Bearer $token'},
    );
    var map = convert.jsonDecode(response.body)["hydra:member"];
    for (var values in map) {
      values['medecin'] = await getMedecinName(values['medecin']);
      request.add(values);
    }
  }
  return request;
}

getMedecinName(String urlMedecin) async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['API_URL'];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  if (token != null) {
    final response = await http.get(
      resolveApiReference(apiUrl ?? "", urlMedecin),
      headers: {'Authorization': 'Bearer $token'},
    );
    var medecin = convert.jsonDecode(response.body)["user"];

    final response2 = await http.get(
      resolveApiReference(apiUrl ?? "", medecin),
      headers: {'Authorization': 'Bearer $token'},
    );
    return convert.jsonDecode(response2.body)["login"];
  }
}

Future<void> addRdv(
    int duree, DateTime date, int patient, int statut, int medecin) async {
  await dotenv.load(fileName: ".env");
  String? apiUrl = dotenv.env['API_URL'];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  if (token != null) {
    final response = await http.post(
      Uri.parse('$apiUrl/api/r_d_vs'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'duree': duree.toString(),
        'date': date.toString(),
        'patient': patient.toString(),
        'statut': statut.toString(),
        'medecin': medecin.toString(),
      },
    );
  }
}

// API Platform may return IRIs already containing the deployment prefix.
Uri resolveApiReference(String base, String reference) {
  final uri = Uri.parse(reference);
  if (uri.hasScheme) return uri;
  final prefix = Uri.parse(base).path.replaceFirst(RegExp(r'/$'), '');
  if (prefix.isNotEmpty && reference.startsWith('$prefix/')) {
    final baseUri = Uri.parse(base);
    return baseUri.hasScheme ? baseUri.resolve(reference) : uri;
  }
  return Uri.parse('$base$reference');
}
