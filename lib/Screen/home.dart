// ignore_for_file: sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:usis_2/Model/AktifIsler.dart';
import 'package:usis_2/Responsive/mobileView.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Responsive/tabletView.dart';
import 'package:usis_2/Responsive/webView.dart';
import 'package:usis_2/Services/remoteService.dart';
import 'package:usis_2/Widget/jobCard.dart';
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
  List<AktifIsler>? searchAktifIs;
  TextEditingController searchCont = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    aktifIs = await RemoteService().getAktifIsler();
    if (aktifIs != null) {
      setState(() {
        searchAktifIs = aktifIs;
        isLoaded = true;
      });
    }
  }

  void searchData(String query) {
    if (searchCont.text != "") {
      final suggestion = searchAktifIs?.where((data) {
        final tezgahKodu = data.tezgahKodu.toLowerCase();
        final isEmriNo = data.ieNo.toString().toLowerCase();
        final operator = data.adSoyad.toString().toLowerCase();
        final input = query.toLowerCase();
        return tezgahKodu.contains(input) || isEmriNo.contains(input) || operator.contains(input);
      }).toList();
      setState(() => aktifIs = suggestion);
    }
    if (searchCont.text == "") {
      setState(() => aktifIs = searchAktifIs);
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
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
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
                      child: SizedBox(
                        width: screenSize.width - 300,
                        child: search(),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateFormat('dd-MM-yyyy').format(
                            DateTime.now(),
                          ),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
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
                    return JobCard(aktifIs: aktifIs, screenSize: screenSize, index: index);
                  },
                ),
              ),
            ),
          ],
        ),
      );
  search() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        controller: searchCont,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            borderSide:
                BorderSide(width: 1, color: Color.fromARGB(241, 255, 193, 7)),
          ),
          contentPadding: EdgeInsets.all(5),
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(241, 255, 193, 7),
          ),
          hintText: "Tezgah kodu, iş emri numarası veya operatör adı ile ara...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
        ),
        onChanged: (value) => searchData(value),
      ),
    );
  }
}

