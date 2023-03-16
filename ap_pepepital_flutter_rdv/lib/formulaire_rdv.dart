import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class FormulaireRdv extends StatefulWidget {
  const FormulaireRdv({super.key});
  @override
  State<FormulaireRdv> createState() => _FormulaireRdvState();
}

class _FormulaireRdvState extends State<FormulaireRdv> {
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
              lastDate: DateTime.now().add(const Duration(days: 365)
              )
            )
          ],
        )
      ),
    );
  }
}
