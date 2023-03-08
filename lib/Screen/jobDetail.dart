// ignore_for_file: file_names, sort_child_properties_last, must_be_immutable
import 'package:flutter/material.dart';
import 'package:usis_2/Model/AktifIsler.dart';
import 'package:usis_2/Responsive/responsive.dart';
import 'package:usis_2/Screen/home.dart';
import 'package:usis_2/Services/remoteService.dart';
import 'package:usis_2/Widget/headerTitle.dart';
import 'package:usis_2/Widget/jobCard.dart';
import 'package:usis_2/constants.dart';

class JobDetail extends StatefulWidget {
  static const String pageName = "/JobDetail";
  const JobDetail({super.key});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

late int secilenID;

class _JobDetailState extends State<JobDetail> {
  bool isLoaded = false;
  List<AktifIsler>? secilenAktifIs;
  @override
  void initState() {
    super.initState();
    getData(secilenID);
  }

  getData(int id) async {
    secilenAktifIs = await RemoteService().getSecilAktifIs(id);
    if (secilenAktifIs != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  gidecek(BuildContext context, String ekran) {
    Navigator.pushNamed(context, ekran);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return responsive(context, screenSize, isLoaded, job);
  }

  Widget job(final BuildContext context, Size screenSize) => Container(
        color: kContentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: HeaderTitle(screenSize: screenSize, title: "SEÇİLEN İŞ"),
            ),
            Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: JobCard(
                      aktifIs: secilenAktifIs,
                      screenSize: screenSize * 2.5,
                      index: 0),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buttonOutlined(Icons.add, 'Yapılan iş kaydet', Colors.red,
                        HomeScreen.pageName),
                    buttonOutlined(Icons.add, 'Arza kaydet', Colors.green,
                        HomeScreen.pageName),
                    buttonOutlined(Icons.add, 'Fire kaydet', Colors.amber,
                        HomeScreen.pageName),
                    buttonOutlined(Icons.add, 'Duruş kaydet', Colors.red,
                        HomeScreen.pageName),
                    buttonOutlined(Icons.add, 'Kalite kontrol', Colors.blueGrey,
                        HomeScreen.pageName),
                    buttonOutlined(Icons.add, 'Op kalite kon.', Colors.pink,
                        HomeScreen.pageName),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget buttonOutlined(IconData icon, String textLable, Color outlineColor,
      String gidilecekEkran) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
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
                  style:
                      const TextStyle(color: Color.fromARGB(241, 255, 193, 7)),
                ),
              ),
            ],
          ),
          onPressed: () {
            gidecek(context, gidilecekEkran);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: kPrimaryColor,
            padding: const EdgeInsets.all(4),
            // backgroundColor: Colors.yellow,
            textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            elevation: 15,
            side: BorderSide(color: outlineColor, width: 2),
          ),
        ),
      ),
    );
  }
}
