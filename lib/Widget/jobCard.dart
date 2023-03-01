// ignore_for_file: file_names, must_be_immutable
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:usis_2/Model/AktifIsler.dart';
import 'package:usis_2/Widget/jobsItems.dart';
import 'package:usis_2/constants.dart';

class JobCard extends StatelessWidget {
  
  final List<AktifIsler>? aktifIs;
  Size screenSize;
  int index;
  JobCard({
    super.key,
    required this.aktifIs,
    required this.screenSize,
    required this.index
  });


  @override
  Widget build(BuildContext context) => Container(
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
                            : Expanded(
                                flex: 4,
                                child: Image.asset(
                                    "assets/image/Worker.png")),
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
            height: 5,
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
                      jobsItems(Icons.numbers_sharp,
                          'Tazgah Adı: ${aktifIs![index].tezgahAdi}'),
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
                      jobsItems(Icons.numbers_sharp,
                          'Tazgah Kodu: ${aktifIs![index].tezgahKodu}'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
}
