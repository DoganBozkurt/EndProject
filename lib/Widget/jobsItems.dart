// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:usis_2/constants.dart';

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
    ),
  );
}
