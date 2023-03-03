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
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
