import 'dart:convert';

List<Personel> personelFromJson(String str) => List<Personel>.from(json.decode(str).map((x) => Personel.fromJson(x)));
String personelToJson(List<Personel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Personel {
  int sNo;
  int kod;
  String ad;
  String soyad;
  Personel(
      {required this.sNo,
      required this.kod,
      required this.ad,
      required this.soyad});

  factory Personel.fromJson(Map<String, dynamic> json) => Personel(
      sNo: json["sNo"],
      kod: json["kod"],
      ad: json["ad"],
      soyad: json["soyad"]);

    Map<String, dynamic> toJson() => {
        "sNo": sNo,
        "kod": kod,
        "ad": ad,
        "soyad": soyad,
    };
}
