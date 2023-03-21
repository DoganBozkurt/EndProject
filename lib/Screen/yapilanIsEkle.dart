// ignore_for_file: sort_child_properties_last

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:usis_2/Screen/jobDetail.dart';
import 'package:usis_2/Services/remoteService.dart';
import 'package:usis_2/constants.dart';

class YapilanIsEkle extends StatefulWidget {
  const YapilanIsEkle({
    super.key,
  });

  @override
  State<YapilanIsEkle> createState() => _YapilanIsEkleState();
}

class _YapilanIsEkleState extends State<YapilanIsEkle> {
  TextEditingController miktar = TextEditingController();
  Map mapPostData = {};
  DateTime? baslamaTarihi;
  String? baslamaTarihiFormatli;
  TimeOfDay? baslamaSaati;
  DateTime? bitisTarihi;
  String? bitisTarihiFormatli;
  TimeOfDay? bitisSaati;

  Future<void> selectDateTime(BuildContext context, int hangiTarih) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (picked != null) {
      setState(() {
        if (hangiTarih == 1) {
          baslamaTarihi = picked;
          baslamaTarihiFormatli =
              DateFormat('dd-MM-yyyy').format(baslamaTarihi!);
          mapPostData.addAll(
              {"Baslangic": DateFormat('yyy-MM-dd').format(baslamaTarihi!)});
        } else {
          bitisTarihi = picked;
          bitisTarihiFormatli = DateFormat('dd-MM-yyyy').format(bitisTarihi!);
          mapPostData
              .addAll({"Bitis": DateFormat('yyy-MM-dd').format(bitisTarihi!)});
        }
      });
    }
  }

  selectTimePicker(int hangiSaat) async {
    var saat = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (saat != null) {
      setState(() {
        if (hangiSaat == 1) {
          baslamaSaati = saat;
          mapPostData.addAll({
            "BaslangicS": baslamaSaati!
                .format(context)
                .substring(0, 5)
                .trimRight()
                .trimLeft()
                .toString()
          });
        } else {
          bitisSaati = saat;
          mapPostData.addAll({
            "BitisS": bitisSaati!
                .format(context)
                .substring(0, 5)
                .trimRight()
                .trimLeft()
                .toString()
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: kContentColor,
      title: const Text("YAPILAN İŞ EKLE"),
      titleTextStyle: const TextStyle(
          color: Color.fromARGB(241, 255, 193, 7), fontSize: 20),
      content: SizedBox(
        width: screenSize.width * 0.4,
        height: screenSize.height * 0.5,
        child: SingleChildScrollView(
          child: Column(
            children: [
              diveder(),
              textField(
                  miktar, 'Yapılan miktarı gir...', Icons.personal_injury),
              buttonOutlined(
                  context,
                  Icons.date_range_rounded,
                  'Başlama Tarihini Seç ',
                  'Tarih şeçilmedi',
                  baslamaTarihiFormatli,
                  1),
              buttonOutlined(
                  context,
                  FontAwesome.clock_o,
                  'Başlama Saatini Seç  ',
                  'Saat şeçilmedi',
                  baslamaSaati?.format(context).toString(),
                  1),
              buttonOutlined(
                  context,
                  Icons.date_range_rounded,
                  'Bitiş Tarihini Seç        ',
                  'Tarih şeçilmedi',
                  bitisTarihiFormatli,
                  2),
              buttonOutlined(
                  context,
                  FontAwesome.clock_o,
                  'Bitiş Saatini Seç         ',
                  'Saat şeçilmedi',
                  bitisSaati?.format(context).toString(),
                  2),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: kContentColor,
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(color: Colors.greenAccent, width: 1),
          ),
          onPressed: () async {
            mapPostData.addAll({"GTTDetayGCID": secilenID});
            if (baslamaTarihiFormatli == null ||
                bitisTarihiFormatli == null ||
                baslamaSaati == null ||
                bitisSaati == null ||
                miktar.text.isEmpty) {
              baslamaTarihiFormatli == null
                  ? eksikBilgi(context, "Başlama Tarihi")
                  : bitisTarihiFormatli == null
                      ? eksikBilgi(context, "Bitiş Tarihi")
                      : baslamaSaati == null
                          ? eksikBilgi(context, "Başlama Saati")
                          : bitisSaati == null
                              ? eksikBilgi(context, "Bitiş Saati")
                              : eksikBilgi(context, "Miktar");
            } else {
              RemoteService().postYapilanIsEkle(mapPostData).then((value) =>
                  islemDialog(context, "İşlem Başarılı", "Yapılan iş kaydedildi.",
                      DialogType.success));
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "KAYDET",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: kContentColor,
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: const BorderSide(
                color: Color.fromARGB(241, 255, 193, 7), width: 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              "İPTAL",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget textField(
      TextEditingController hintTxt, String nullHintTxt, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: hintTxt,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(25),
            hintText: hintTxt.text == "" ? nullHintTxt : hintTxt.text,
            hintStyle: const TextStyle(fontSize: 16, color: Colors.greenAccent),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(241, 255, 193, 7))),
            suffixIcon: Icon(icon),
            suffixIconColor: const Color.fromARGB(241, 255, 193, 7)),
      ),
    );
  }

  Widget buttonOutlined(BuildContext context, IconData icon, String textLable,
      String bilgiSecText, String? bilgiSeciliMi, int hangiTarihVeSaat) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(241, 255, 193, 7),
                  size: 35,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    textLable,
                    style: const TextStyle(color: Colors.greenAccent),
                  ),
                ),
              ],
            ),
            onPressed: () {
              icon == FontAwesome.clock_o
                  ? selectTimePicker(hangiTarihVeSaat)
                  : selectDateTime(context, hangiTarihVeSaat);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: kPrimaryColor,
              padding: const EdgeInsets.all(4),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              elevation: 15,
              side: const BorderSide(
                  color: Color.fromARGB(241, 255, 193, 7), width: 1),
            ),
          ),
        ),
        bilgiSeciliMi != null
            ? Text(
                bilgiSeciliMi,
                style: const TextStyle(
                  color: Colors.greenAccent,
                ),
              )
            : Text(":$bilgiSecText",
                style: const TextStyle(fontSize: 18, color: Colors.greenAccent))
      ],
    );
  }
}

