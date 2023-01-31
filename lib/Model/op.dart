import 'dart:convert';

List<Op> opFromJson(String str)=> List<Op>.from(json.decode(str).map((x)=>Op.fromJson(x)));
class Op {
  int sNo;
  String iENo;
  String cariAdi;
  String stokKodu;
  String stokAdi;
  String oPNo;
  String oPAdi;
  Op(
      {required this.sNo,
      required this.iENo,
      required this.cariAdi,
      required this.stokKodu,
      required this.stokAdi,
      required this.oPNo,
      required this.oPAdi});
  factory Op.fromJson(Map<String, dynamic> json) => Op(
      sNo: json["sNo"],
      iENo: json["iENo"],
      cariAdi: json["cariAdi"],
      stokKodu: json["stokKodu"],
      stokAdi: json["stokAdi"],
      oPNo: json["oPNo"],
      oPAdi: json["oPAdi"]);
}
