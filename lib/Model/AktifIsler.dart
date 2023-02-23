// ignore_for_file: file_names

import 'dart:convert';

List<AktifIsler> aktifIslerFromJson(String str) =>
    List<AktifIsler>.from(json.decode(str).map((x) => AktifIsler.fromJson(x)));

class AktifIsler {
  int sNo;
  String adSoyad;
  dynamic resim;
  DateTime baslamaTarihi;
  DateTime baslamaSaati;
  String tezgahKodu;
  String tezgahAdi;
  String ieNo;
  dynamic stokKodu;
  dynamic stokAdi;
  dynamic operasyonNo;
  dynamic operasyonAd;
  double miktar;
  double yapilanMiktar;
  double kalanMiktar;
  AktifIsler(
      {required this.sNo,
      required this.adSoyad,
      this.resim,
      required this.baslamaTarihi,
      required this.baslamaSaati,
      required this.tezgahKodu,
      required this.tezgahAdi,
      required this.ieNo,
      this.stokKodu,
      this.stokAdi,
      this.operasyonNo,
      this.operasyonAd,
      required this.miktar,
      required this.yapilanMiktar,
      required this.kalanMiktar});
  factory AktifIsler.fromJson(Map<String, dynamic> json) => AktifIsler(
        sNo: json["sNo"],
        adSoyad: json["adSoyad"],
        resim: json["resim"],
        baslamaTarihi: DateTime.parse(json["baslamaTarihi"]),
        baslamaSaati: DateTime.parse(json["baslamaSaati"]),
        tezgahKodu: json["tezgahKodu"],
        tezgahAdi: json["tezgahAdi"],
        ieNo: json["ieNo"],
        stokKodu: json["stokKodu"],
        stokAdi: json["stokAdi"],
        operasyonNo: json["operasyonNo"],
        operasyonAd: json["operasyonAd"],
        miktar: json["miktar"],
        yapilanMiktar: json["yapilanMiktar"],
        kalanMiktar: json["kalanMiktar"]);
}
