import 'dart:convert';

List<Op> opFromJson(String str)=> List<Op>.from(json.decode(str).map((x)=>Op.fromJson(x)));
class Op {
  int sNo;
  String ieNo;
  String cariAdi;
  String stokKodu;
  String stokAdi;
  String opNo;
  String opAdi;
  Op(
      {required this.sNo,
      required this.ieNo,
      required this.cariAdi,
      required this.stokKodu,
      required this.stokAdi,
      required this.opNo,
      required this.opAdi});
  factory Op.fromJson(Map<String, dynamic> json) => Op(
      sNo: json["sNo"],
      ieNo: json["ieNo"],
      cariAdi: json["cariAdi"],
      stokKodu: json["stokKodu"],
      stokAdi: json["stokAdi"],
      opNo: json["opNo"],
      opAdi: json["opAdi"]);
}
