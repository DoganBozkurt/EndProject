// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable, unnecessary_null_comparison, sort_child_properties_last, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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

  selectTimePicker() async {
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
    return responsive(context, screenSize, isLoaded, columnIsPanelli);
  }

  Widget columnIsPanelli(final BuildContext context, Size screenSize) =>
      Container(
        color: kContentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderTitle(screenSize: screenSize, title: "İŞ EKLE"),
            listDialog(
                selectPersonel, personelSec, "Operatör Seç", Icons.person),
            listDialog(selectTezgah, tezgahSec, "Tezgah Seç", Icons.list),
            listDialog(
                selectOp, opSec, "Ürün Ve Operasyon Seç", Icons.join_full),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                buttonOutlined(context, Icons.date_range_rounded, 'Tarih seç', 'Tarih şeçilmedi', baslamaTarihiFormatli),
                buttonOutlined(
                    context,
                    FontAwesome.clock_o,
                    'Saat seç',
                    'Saat şeçilmedi',
                    baslamaSaati?.format(context).toString()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: kContentColor,
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: const BorderSide(color: Colors.greenAccent, width: 1),
                ),
                onPressed: () async {
                  if (personelSec.text != "" &&
                      tezgahSec.text != "" &&
                      opSec.text != "" &&
                      baslamaSaati != "" &&
                      baslamaTarihi != "") {
                    var result =
                        await RemoteService().postIsBaslat(mapPostData);
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
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "İ Ş   B A Ş L A T",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
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

  Widget buttonOutlined(BuildContext context, IconData icon, String textLable, String bilgiSecText, String? bilgiSeciliMi) {
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
                    style: const TextStyle(
                        color: Colors.greenAccent),
                  ),
                ),
              ],
            ),
            onPressed: () {
              textLable == 'Saat seç'
                  ? selectTimePicker()
                  : selectDateTime(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: kPrimaryColor,
              padding: const EdgeInsets.all(4),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              elevation: 15,
              side: const BorderSide(color: Color.fromARGB(241, 255, 193, 7), width: 1),
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
