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
      child: Scaffold(
        resizeToAvoidBottomInset: false, //keyboard hatasını çözer
        drawer: !ResponsiveUtils.isScreenWeb(context) ? mobileMenu() : null,
        body: Visibility(
          visible: isLoaded,
          child: ResponsiveUtils(
            screenWeb: webView(jobsListView, screenSize, context),
            screenTablet: tabletView(jobsListView, screenSize, context),
            screenMobile: mobileView(jobsListView, screenSize, context),
          ),
          replacement: const Center(child: CircularProgressIndicator(),),
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
                child: Stack(
                  children: [
                    const Positioned(
                      top: 2,
                      right: 80,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.date_range,
                          size: 35,
                          color: Color.fromARGB(241, 255, 193, 7),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(DateFormat('dd-MM-yyyy').format(
                          DateTime.now(),
                        ),style:  const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),
                  ],
                ),
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
                    return Container(
                      margin: const EdgeInsets.all(20),
                      width: screenSize.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(241, 255, 193, 7),
                            Color.fromARGB(200, 255, 193, 7),
                          ])),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        aktifIs?[index].resim != null
                                            ? Expanded(
                                                flex: 4,
                                                child: Image.memory(
                                                  base64Decode(
                                                      aktifIs![index].resim),
                                                ),
                                              )
                                            :  Expanded(
                                                flex: 4,
                                                child: Image.asset("assets/image/Worker.png")),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              aktifIs![index].adSoyad,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        jobsItems(FontAwesome.circle,
                                            'Yapılacak Miktar : ${aktifIs![index].miktar}'),
                                        jobsItems(FontAwesome.arrow_circle_left,
                                            'Yapılan Miktar   : ${aktifIs![index].yapilanMiktar}'),
                                        jobsItems(FontAwesome.circle_o_notch,
                                            'Kalan Miktar     : ${aktifIs![index].kalanMiktar}'),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                          const Divider(
                            height: 35,
                            color: kContentColor,
                          ),
                          Expanded(
                            flex: 4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      jobsItems(Icons.date_range,
                                          'Başlama Tarihi: ${DateFormat('dd-MM-yyyy').format(aktifIs![index].baslamaTarihi)}'),
                                      jobsItems(Feather.clock,
                                          'Başlama Saati: ${DateFormat('mm:ss').format(aktifIs![index].baslamaSaati)}'),
                                      jobsItems(Icons.numbers,
                                          'İş Em No: ${aktifIs![index].ieNo}'),
                                      jobsItems(
                                          Icons.production_quantity_limits,
                                          'Cari: Cari Eklenecek'),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      jobsItems(Icons.code,
                                          'Ürün Kodu: ${aktifIs![index].stokKodu}'),
                                      jobsItems(
                                          Icons
                                              .production_quantity_limits_sharp,
                                          'Ürün Adı: ${aktifIs![index].stokAdi}'),
                                      jobsItems(Icons.numbers,
                                          'Operasyon No: ${aktifIs![index].operasyonNo}'),
                                      jobsItems(Icons.near_me,
                                          'Operasyon Adı: ${aktifIs![index].operasyonAd}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
  return Padding(
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
              size: 25.0,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            data,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
