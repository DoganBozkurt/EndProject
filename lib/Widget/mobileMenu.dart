// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget mobileMenu() => Drawer(
      backgroundColor: const Color.fromRGBO(34, 43, 62, 1),
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const DrawerHeader(child: Icon(Icons.favorite)),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text("D A S H B O A R D"),
          ),
        ],
      ),
    );