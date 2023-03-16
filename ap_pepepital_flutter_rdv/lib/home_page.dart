import 'package:ap_pepepital_flutter_rdv/rdv_page.dart';
import 'package:ap_pepepital_flutter_rdv/formulaire_rdv.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      enableFeedback: true,
      fixedSize: const Size(250, 300),
    );
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(20.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.published_with_changes_sharp),
            style: style,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const RDV();
                  },
                ),
              );
            },
            label: const Text("Voir vos RDVs"),
          ),
        ),Container(
          margin: const EdgeInsets.all(20.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add_circle_outline),
            style: style,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const FormulaireRdv();
                  },
                ),
              );
            },
            label: const Text("Prendre rendez-vous"),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20.0),
        )
      ],
    );
  }
}
