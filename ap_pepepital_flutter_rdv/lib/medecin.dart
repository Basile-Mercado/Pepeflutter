class Medecin{
  int id;
  String assistant;
  List<String> rdvs;
  

  Medecin(this.id, this.assistant, this.rdvs);

  factory Medecin.fromJson(dynamic json) {
    return Medecin(json['id'] as int, json['assistant'] as String, json['rdvs'] as List<String>);
  }
}