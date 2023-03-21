// ignore_for_file: file_names, sort_child_properties_last, use_build_context_synchronously
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:usis_2/Screen/jobDetail.dart';
import 'package:usis_2/Services/remoteService.dart';

import '../Model/durus.dart';
import '../constants.dart';

class DurusKaydet extends StatefulWidget {
  const DurusKaydet({super.key});

  @override
  State<DurusKaydet> createState() => _DurusKaydetState();
}

class _DurusKaydetState extends State<DurusKaydet> {
  bool isLoaded = false;
  List<Durus>? durus;
  Map mapPostData = {};
  DateTime? tarih;
  String? tarihFormatli;
  TimeOfDay? saat;
  TextEditingController hour = TextEditingController();
  TextEditingController minute = TextEditingController();
  TextEditingController durusSec = TextEditingController();
  final List<SelectedListItem> selectDurus = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    durus = await RemoteService().getDurus();
    if (durus != null) {
      setState(() {
        isLoaded = true;
      });
      durus
          ?.map((e) => selectDurus.add(SelectedListItem(
              name: '${e.durusKodu}  - ${e.durusAdi}',
              value: e.durusID.toString())))
          .toList();
    }
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (picked != null) {
      setState(() {
        tarih = picked;
        tarihFormatli = DateFormat('dd-MM-yyyy').format(tarih!);
        mapPostData.addAll({"Tarih": DateFormat('yyy-MM-dd').format(tarih!)});
      });
    }
  }

  selectTimePicker() async {
    var saat2 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (saat2 != null) {
      setState(() {
        saat = saat2;
        mapPostData.addAll({
          "Saat": saat!
              .format(context)
              .substring(0, 5)
              .trimRight()
              .trimLeft()
              .toString()
        });
      });
    }
  }

  void onTextFieldTap(List<SelectedListItem> pData, String listTitle) {
    DropDownState(
      DropDown(
          enableMultipleSelection: false,
          data: pData,
          bottomSheetTitle: Text(
            listTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          selectedItems: (List<dynamic> selectedList) {
            for (var item in selectedList) {
              if (item is SelectedListItem) {
                durusSec.text = item.name;
                mapPostData.addAll({"Kod": item.value});
              }
            }
          }),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Visibility(
      visible: isLoaded,
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        backgroundColor: kContentColor,
        title: const Text("DURUŞ KAYDET"),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(241, 255, 193, 7), fontSize: 20),
        content: SizedBox(
          width: screenSize.width * 0.4,
          height: screenSize.height * 0.5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                diveder(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: textField(hour, '00')),
                    const Text(
                      "+",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Expanded(child: textField(minute, '00')),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, bottom: 8),
                        child: Text(
                          "Duruş Süresi",
                          style: TextStyle(
                              color: Colors.greenAccent, fontSize: 20),
                        ),
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox())
                  ],
                ),
                listDialog(selectDurus, durusSec, "Duruş Seç", Icons.list),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, bottom: 8),
                        child: Text(
                          "Saat",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "+",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, bottom: 8),
                        child: Text(
                          "Dakika",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Expanded(flex: 2, child: SizedBox())
                  ],
                ),
                buttonOutlined(context, Icons.date_range_rounded,
                    'Başlama Tarihini Seç ', 'Tarih şeçilmedi', tarihFormatli),
                buttonOutlined(
                    context,
                    FontAwesome.clock_o,
                    'Başlama Saatini Seç  ',
                    'Saat şeçilmedi',
                    saat?.format(context).toString()),
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
              int toplamDakika =
                  ((int.parse(hour.text) * 60 + int.parse(minute.text)));
              mapPostData
                  .addAll({"Sure": toplamDakika, "GTTDetayGCID": secilenID});
              if (hour.text.isEmpty ||
                  minute.text.isEmpty ||
                  durusSec.text.isEmpty ||
                  tarihFormatli == null ||
                  saat == null) {
              } else {
                bool sonuc = await RemoteService().postDurus(mapPostData);
                if (sonuc == true) {
                  islemDialog(context, "İşlem Başarılı", "Duruş kaydetdildi",
                      DialogType.success);
                } else {
                  islemDialog(
                      context,
                      "İşlem Başarısız",
                      "Bir Sorun oluştu, duruş kaydedilmedi!",
                      DialogType.error);
                }
                print(mapPostData);
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
      ),
      replacement: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget textField(TextEditingController hintTxt, String nullHintTxt) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: hintTxt,
        inputFormatters: [
          LengthLimitingTextInputFormatter(2),
          // for below version 2 use this
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          // for version 2 and greater youcan also use this
          FilteringTextInputFormatter.digitsOnly
        ],
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
            suffixIconColor: const Color.fromARGB(241, 255, 193, 7)),
      ),
    );
  }

  Widget buttonOutlined(BuildContext context, IconData icon, String textLable,
      String bilgiSecText, String? bilgiSeciliMi) {
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
                  ? selectTimePicker()
                  : selectDateTime(context);
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

  Padding listDialog(List<SelectedListItem> selectList,
      TextEditingController hintTxt, String nullHintTxt, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: hintTxt,
        readOnly: true,
        onTap: () => onTextFieldTap(selectList, nullHintTxt),
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
                borderSide: BorderSide(width: 1, color: Colors.greenAccent)),
            suffixIcon: Icon(icon),
            suffixIconColor: const Color.fromARGB(241, 255, 193, 7)),
      ),
    );
  }
}
