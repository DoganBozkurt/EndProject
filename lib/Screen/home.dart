import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:usis_2/Responsive/mobileView.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Responsive/tabletView.dart';
import 'package:usis_2/Responsive/webView.dart';
import 'package:usis_2/Widget/mobileMenu.dart';
import 'package:usis_2/constants.dart';

class HomeScreen extends StatefulWidget {
 static const String pageName = "/";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //keyboard hatasını çözer
        drawer: !ResponsiveUtils.isScreenWeb(context) ? mobileMenu() : null,
        body: ResponsiveUtils(
          screenWeb: webView(jobsListView,screenSize, context),
          screenTablet: tabletView(jobsListView,screenSize, context),
          screenMobile: mobileView(jobsListView,screenSize, context),
        ),
      ),
    );
  }
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
            flex: 7,
            child: FractionallySizedBox(
              heightFactor: 0.8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 400,
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.black,
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Feather.edit,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          jobsItems(Feather.user, "Personel: Ali Veli"),
                          jobsItems(
                              Icons.date_range, "Başlama Tarihi: 12.01.2023"),
                          jobsItems(Feather.clock, "Başlama Saati: 16:25"),
                          jobsItems(Icons.numbers, "İş Em No: 155484"),
                          jobsItems(Icons.production_quantity_limits, "Ürün Bilgileri: xxxx"),
                         ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                height: 100, color: kContentColor),
          ),
        ],
      ),
    );

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
