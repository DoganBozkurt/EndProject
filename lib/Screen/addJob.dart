// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable, unnecessary_null_comparison, sort_child_properties_last, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:usis_2/Model/op.dart';
import 'package:usis_2/Model/personel.dart';
import 'package:usis_2/Model/tezgah.dart';
import 'package:usis_2/Responsive/responsive.dart';
import 'package:usis_2/Services/remoteService.dart';
import 'package:usis_2/Widget/headerTitle.dart';
import 'package:usis_2/constants.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});
  static const String pageName = "/AddJobScreen";
  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  bool isLoaded = false;
  DateTime? baslamaTarihi;
  String? baslamaTarihiFormatli;
  TimeOfDay? baslamaSaati;
  final List<SelectedListItem> selectPersonel = [];
  final List<SelectedListItem> selectTezgah = [];
  final List<SelectedListItem> selectOp = [];
  List<Personel>? personel;
  List<Tezgah>? tezgah;
  List<Op>? op;

  String secilenPersonel = "";
  TextEditingController personelSec = TextEditingController();
  TextEditingController tezgahSec = TextEditingController();
  TextEditingController opSec = TextEditingController();
  Map mapPostData = {};
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    personel = await RemoteService().getPersonel();
    tezgah = await RemoteService().getTezgah();
    op = await RemoteService().getOp();
    if (personel != null && tezgah != null && op != null) {
      setState(() {
        isLoaded = true;
      });
      personel
          ?.map((e) => selectPersonel.add(SelectedListItem(
              name: '${e.ad} ${e.soyad}', value: e.kod.toString())))
          .toList();

      tezgah
          ?.map((e) => selectTezgah.add(SelectedListItem(
              name: "${e.tezgahKodu}-${e.tezgahAdi}",
              value: e.tkkid.toString())))
          .toList();

      op
          ?.map((e) => selectOp.add(SelectedListItem(
              name: "${e.cariAdi} | ${e.stokKodu}",
              value: e.ieUrPlID.toString())))
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
        baslamaTarihi = picked;
        baslamaTarihiFormatli = DateFormat('dd-MM-yyyy').format(baslamaTarihi!);
        mapPostData
            .addAll({"Tarih": DateFormat('yyy-MM-dd').format(baslamaTarihi!)});
      });
    }
  }

  void selectTimePicker() async {
    var saat = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (saat != null) {
      setState(() {
        baslamaSaati = saat;
        mapPostData.addAll({
          "Saat": baslamaSaati!
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
                switch (listTitle) {
                  case "Operatör Seç":
                    personelSec.text = item.name;
                    mapPostData.addAll({"Kod": item.value});
                    break;
                  case "Tezgah Seç":
                    tezgahSec.text = item.name;
                    mapPostData.addAll({"TKKID": item.value});
                    break;
                  case "Ürün Ve Operasyon Seç":
                    opSec.text = item.name;
                    mapPostData.addAll({"IEUrplID": item.value});
                    break;
                }
              }
            }
          }),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return responsive(context, screenSize,isLoaded,columnIsPanelli);
  }

  Widget columnIsPanelli(final BuildContext context, Size screenSize) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTitle(screenSize: screenSize,title: "İŞ EKLE"),
          listDialog(selectPersonel, personelSec, "Operatör Seç", Icons.person),
          listDialog(selectTezgah, tezgahSec, "Tezgah Seç", Icons.list),
          listDialog(selectOp, opSec, "Ürün Ve Operasyon Seç", Icons.join_full),
          Row(
            children: [
              rowTarih(context),
              rowSaat(context),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shadowColor: kContentColor,
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () async {
                if (personelSec.text != "" &&
                    tezgahSec.text != "" &&
                    opSec.text != "" &&
                    baslamaSaati != "" &&
                    baslamaTarihi != "") {
                  var result = await RemoteService().postIsBaslat(mapPostData);
                  if (result == true) {
                    islemDialog(context, "İşlem Başarılı",
                        "İş başarıyla başlatıldı.", DialogType.success);
                  } else {
                    islemDialog(
                        context,
                        "İşlem Başarısız",
                        "İş başlatılmadı lütfen tekrar deneyiniz.",
                        DialogType.error);
                  }
                } else {
                  islemDialog(
                      context,
                      "Eksik Alan",
                      "İş başlatılmadı lütfen tüm gerekli bilgileri giriniz.",
                      DialogType.info);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "BAŞLA",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
        ],
      );

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
          hintStyle: const TextStyle(fontSize: 20),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          suffixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget rowTarih(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(241, 255, 193, 7),
                  Color.fromARGB(200, 255, 193, 7),
                ]),
                borderRadius: BorderRadius.circular(2),
                boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 3)]),
            child: TextButton(
              onPressed: () {
                selectDateTime(context);
              },
              child: const Text(
                "Tarih Seç",
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
            ),
          ),
        ),
        baslamaTarihiFormatli != null
            ? Text("$baslamaTarihiFormatli")
            : const Text(":Tarih şeçilmedi",style: TextStyle(fontSize: 18))
      ],
    );
  }

  Widget rowSaat(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(241, 255, 193, 7),
                  Color.fromARGB(200, 255, 193, 7),
                ]),
                borderRadius: BorderRadius.circular(2),
                boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 3)]),
            child: TextButton(
              onPressed: () {
                selectTimePicker();
              },
              child: const Text(
                "Saat Seç",
                style: TextStyle(color: Colors.white,fontSize: 20),
              ),
            ),
          ),
        ),
        baslamaSaati != null
            ? Text(baslamaSaati!.format(context).toString())
            : const Text(":Saat şeçilmedi",style: TextStyle(fontSize: 18))
      ],
    );
  }
}


