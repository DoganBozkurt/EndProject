// ignore_for_file: sort_child_properties_last

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:usis_2/Model/AktifIsler.dart';
import 'package:usis_2/Responsive/mobileView.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Responsive/tabletView.dart';
import 'package:usis_2/Responsive/webView.dart';
import 'package:usis_2/Services/remoteService.dart';
import 'package:usis_2/Widget/mobileMenu.dart';
import 'package:usis_2/constants.dart';

class HomeScreen extends StatefulWidget {
  static const String pageName = "/";

  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  List<AktifIsler>? aktifIs;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    aktifIs = await RemoteService().getAktifIsler();
    if (aktifIs != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Visibility(
        visible: isLoaded,
        child: Scaffold(
          resizeToAvoidBottomInset: false, //keyboard hatasını çözer
          drawer: !ResponsiveUtils.isScreenWeb(context) ? mobileMenu() : null,
          body: ResponsiveUtils(
            screenWeb: webView(jobsListView, screenSize, context),
            screenTablet: tabletView(jobsListView, screenSize, context),
            screenMobile: mobileView(jobsListView, screenSize, context),
          ),
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget jobsListView(final BuildContext context, Size screenSize) => Container(
        color: kContentColor,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: kPrimaryColor,
                width: screenSize.width,
              ),
            ),
            Expanded(
              flex: 9,
              child: FractionallySizedBox(
                heightFactor: 0.8,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: aktifIs?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 500,
                      child: Card(
                        elevation: 8,
                        shadowColor: Colors.black,
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                aktifIs?[index].resim!=null?Expanded(
                                    flex: 4,
                                    child: Image.memory(
                                      base64Decode(aktifIs![index].resim),
                                    ),
                                  ):const Expanded(
                                    flex: 4,
                                    child: Text("Resim yok")
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(aktifIs![index].adSoyad),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            jobsItems(Icons.date_range,
                                "Başlama Tarihi: ${DateFormat('dd-MM-yyyy').format(aktifIs![index].baslamaTarihi)}"),
                            jobsItems(Feather.clock, "Başlama Saati: ${DateFormat('mm:ss').format(aktifIs![index].baslamaSaati)}"),
                            jobsItems(Icons.numbers, "İş Em No: ${aktifIs![index].ieNo}"),
                            jobsItems(Icons.production_quantity_limits,
                                "Ürün Bilgileri: ${aktifIs![index].operasyonAd}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(height: 100, color: kContentColor),
            ),
          ],
        ),
      );
}

Widget jobsItems(IconData icon, String data) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                size: 20.0,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(data),
          ),
        ],
      ),
    ),
  );
}
