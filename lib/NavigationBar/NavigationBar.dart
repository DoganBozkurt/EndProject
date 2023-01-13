// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:usis_2/NavigationBar/src/CompanyName.dart';
import 'package:usis_2/NavigationBar/src/NavBar.dart';
import 'package:usis_2/NavigationBar/src/NavBarItems.dart';

class NavigationBarr extends StatefulWidget {
  const NavigationBarr({super.key});

  @override
  State<NavigationBarr> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarr> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xff333951),
        // ignore: prefer_const_literals_to_create_immutables
        child: Stack(children: [
          const CompanyName(),
          const Align(
            alignment: Alignment.center,
            child: NavBar(),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: NavBarItem(
              icon: Feather.log_out,
              active: false,
            ),
          ),
        ]),
      ),
    );
  }
}
