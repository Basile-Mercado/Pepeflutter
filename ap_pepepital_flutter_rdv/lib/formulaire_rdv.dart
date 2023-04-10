import 'package:flutter/material.dart';


const List<String> list = <String>['Medecin 1', 'Medecin 2', 'Medecin 3', 'Medecin 4'];

class FormulaireRdv extends StatelessWidget {
  const FormulaireRdv({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(        
        body:  Center(
          child: DropdownButtonExample(),
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
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prendre rendez-vous"),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              InputDatePickerFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)))
            ],
          )),

    );
  }
}
