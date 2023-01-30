// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable, unnecessary_null_comparison
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:usis_2/Model/personel.dart';
import 'package:usis_2/Responsive/mobileView.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Responsive/tabletView.dart';
import 'package:usis_2/Responsive/webView.dart';
import 'package:usis_2/Services/remoteService.dart';
import 'package:usis_2/constants.dart';
import '../Widget/mobileMenu.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});
  static const String pageName = "/AddJobScreen";
  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  DateTime? baslamaTarihi;
  String? baslamaTarihiFormatli;
  TimeOfDay? baslamaSaati;
  final List<SelectedListItem> selectPersonel = [];
  List<Personel>? personel;
  String secilenPersonel="";
  TextEditingController personelSec = TextEditingController();
  TextEditingController fiyat = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    personel = await RemoteService().getPersonel();
    if (personel != null) {
      personel
          ?.map((e) => selectPersonel.add(SelectedListItem(
              name: '${e.ad} ${e.soyad}', value: e.kod.toString())))
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
      });
    }
  }

  void selectTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) => setState(() {
          baslamaSaati = value;
        }));
  }

  void onTextFieldTapPersonel(List<SelectedListItem> pData) {
    DropDownState(
      DropDown(
          enableMultipleSelection: false,
          data: pData,
          bottomSheetTitle: const Text(
            "Personel Listesi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          selectedItems: (List<dynamic> selectedList) {
            for (var item in selectedList) {
              if (item is SelectedListItem) {
                personelSec.text=item.name;
              }
            }
          }),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //keyboard hatasını çözer
        drawer: !ResponsiveUtils.isScreenWeb(context) ? mobileMenu() : null,
        body: ResponsiveUtils(
          screenWeb: webView(columnIsPanelli, screenSize, context),
          screenTablet: tabletView(columnIsPanelli, screenSize, context),
          screenMobile: mobileView(columnIsPanelli, screenSize, context),
        ),
      ),
    );
  }

  Widget columnIsPanelli(final BuildContext context, Size screenSize) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "İŞ EKLEME PANELİ",
            style: TextStyle(color: kPrimaryColor, fontSize: 18),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: personelSec,
              readOnly: true,
              onTap: () => onTextFieldTapPersonel(selectPersonel),
              decoration:  InputDecoration(
                contentPadding: const EdgeInsets.all(25),
                hintText: personelSec.text == "" ? "Personel seç" : personelSec.text,
                hintStyle: const TextStyle(fontSize: 14),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                suffixIcon: const Icon(Icons.person),
              ),
            ),
          ),
          adetFiyatTextField("Ürün Bilgileri", fiyat),
          Row(
            children: [
              rowTarih(context),
              rowSaat(context),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shadowColor: kContentColor,
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("BAŞLA"),
            ),
          ),
        ],
      );

  Widget rowTarih(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 3)]),
            child: TextButton(
              onPressed: () {
                selectDateTime(context);
              },
              child: const Text(
                "Tarih Seç",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        baslamaTarihiFormatli != null
            ? Text("$baslamaTarihiFormatli")
            : const Text(":Tarih şeçilmedi")
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
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: const <BoxShadow>[BoxShadow(blurRadius: 3)]),
            child: TextButton(
              onPressed: () {
                selectTimePicker();
              },
              child: const Text(
                "Saat Seç",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        baslamaSaati != null
            ? Text(baslamaSaati!.format(context).toString())
            : const Text(":Saat şeçilmedi")
      ],
    );
  }
}

Padding adetFiyatTextField(String hint, TextEditingController kontroler) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: kontroler,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(25),
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    ),
  );
}
