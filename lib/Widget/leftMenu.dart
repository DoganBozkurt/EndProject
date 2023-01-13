// ignore_for_file: file_names

import 'package:flutter/material.dart';

final List<String> iconItems = ["home", "home", "home", "home"];
Widget leftMenu() => Container(
      color: const Color.fromRGBO(34, 43, 62, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
           Container(
              margin: const EdgeInsets.only(top: 75),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      child: const Icon(
                        Icons.home,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () => {
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () => {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      child: const Icon(
                        Icons.create,
                        size: 30,
                        color: Colors.white,
                      ),
                      onTap: () => {},
                    ),
                  ),
                ],
              ),
            ),
         ],
      ),
    );
