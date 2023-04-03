import 'dart:convert';

import 'package:ap_pepepital_flutter_rdv/home_page.dart';
import 'package:ap_pepepital_flutter_rdv/page_profil.dart';
import 'package:ap_pepepital_flutter_rdv/patient_home.dart';
import 'package:flutter/material.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'formulaire.dart';

void main() {
  runApp(const MyApp());
}

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final jwt = prefs.getString('token');
  return jwt;
}

Future<List> getRole() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final jwt = prefs.getString('token');
  final payload = jwt?.split('.')[1];
  final String decoded =
      payload != null ? B64urlEncRfc7515.decodeUtf8(payload) : '';
  final List roles = decoded.isNotEmpty ? jsonDecode(decoded)["roles"] : [];
  return roles;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pepepital RDV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blue[900]),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentPage = 0;
  bool _isLoggedIn = false;
  bool _hasRole = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  Future<void> checkLoginStatus() async {
    final token = await getToken();
    final roles = await getRole();

    setState(() {
      _isLoggedIn = token != null;
      _hasRole = roles.contains('ROLE_PATIENT');
    });
  }

  /*Future<void> setRoute() async {
    final roles = await getRole();
    if (roles.contains('ROLE_PATIENT')) {
      _hasRole = roles.contains('ROLE_PATIENT');
    } else if (roles.contains('ROLE_MEDECIN')) {
      _hasRole = roles.contains('ROLE_MEDECIn');
    } else if (roles.contains('ROLE_ASSISTANT')) {
      _hasRole = roles.contains('ROLE_ASSISTANT');
    }
  }*/

  void onTabTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (_currentPage) {
      case 0:
        body = _isLoggedIn && _hasRole ? const PatientHome() : const HomePage();
        break;
      case 1:
        body = _isLoggedIn ? const Profil() : const Formulaire();
        break;
      default:
        body = _isLoggedIn ? const HomePage() : const Formulaire();
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pepepital RDV'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline))
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) => onTabTapped(index),
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.black,
        iconSize: 32,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
