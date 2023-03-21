import 'dart:convert';

List<Durus> durusFromJson(String str) =>
    List<Durus>.from(json.decode(str).map((x) => Durus.fromJson(x)));

class Durus {
  int durusID;
  String durusKodu;
  String durusAdi;
  Durus(
      {required this.durusID, required this.durusAdi, required this.durusKodu});
  factory Durus.fromJson(Map<String, dynamic> json) => Durus(
      durusID: json["durusID"],
      durusAdi: json["durusAdi"],
      durusKodu: json["durusKodu"]);
}
