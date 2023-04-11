import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'functions/apiRequest.dart';

class RDV extends StatefulWidget {
  const RDV({super.key});
  @override
  State<RDV> createState() => _RDVState();
}

Future<List> getRDV() async {
  var rdv = await getLesRdvs();
  return rdv;
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
                      '${DateFormat('dd/MM/yyyy à hh:mm').format(DateTime.parse(rdvItem['date']))} ${rdvItem['medecin']}'),
                  leading: CircleAvatar(
                    child: Text(rdvItem['id'].toString()),
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
