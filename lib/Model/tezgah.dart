import 'dart:convert';

List<Tezgah> tezgahFromJson(String str)=> List<Tezgah>.from(json.decode(str).map((x)=>Tezgah.fromJson(x)));
class Tezgah {
  int sNo;
  int tkkid;
  String tezgahAdi;
  String tezgahKodu;

  Tezgah({required this.sNo,required this.tkkid,required this.tezgahAdi,required this.tezgahKodu});

  factory Tezgah.fromJson(Map<String,dynamic> json)=> Tezgah(
  sNo: json["sNo"], 
  tkkid: json["tkkid"], 
  tezgahAdi: json["tezgahAdi"], 
  tezgahKodu: json["tezgahKodu"]);
}
