// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:usis_2/NavigationBar/src/NavBarItems.dart';
import 'package:usis_2/Screen/addJob.dart';
import 'package:usis_2/Screen/home.dart';
import 'package:usis_2/Screen/jobDetail.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> selected = [false, false, false, false, false];
  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i == n) {
        selected[i] = true;
      } else {
        selected[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.0,
      child: Column(
        children: [
          NavBarItem(
            icon: Feather.home,
            active: selected[0],
            touched: () {
              setState(() {
                select(0);
              });
              Navigator.pushNamed(context, HomeScreen.pageName);
            },
          ),
          NavBarItem(
            icon: Feather.plus_circle,
            active: selected[1],
            touched: () {
              setState(() {
                select(1);
              });
              Navigator.pushNamed(context, AddJobScreen.pageName);
            },
          ),
          NavBarItem(
            icon: Feather.folder,
            active: selected[2],
            touched: () {
              setState(() {
                select(2);
              });
               Navigator.pushNamed(context, JobDetail.pageName);
            },
          ),
          NavBarItem(
            icon: Feather.message_square,
            active: selected[3],
            touched: () {
              setState(() {
                select(3);
              });
            },
          ),
          NavBarItem(
            icon: Feather.settings,
            active: selected[4],
            touched: () {
              setState(() {
                select(4);
              });
            },
          ),
        ],
      ),
    );
  }
}