import 'package:ap_pepepital_flutter_rdv/get_rdv.dart';
import 'package:flutter/material.dart';

class PatientHome extends StatelessWidget {
  const PatientHome({super.key});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      enableFeedback: true,
      fixedSize: const Size(300, 200),
    );
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.all(10.0),
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
        ),
        /*Container(
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.all(20.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add_circle_outline),
            style: style,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return null;
                  },
                ),
              );
            },
            label: const Text("Prendre rendez-vous"),
          ),
        ),*/
        Container(
          margin: const EdgeInsets.all(20.0),
        )
      ],
    );
  }
}
