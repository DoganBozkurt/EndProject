import 'package:flutter/material.dart';
import 'package:usis_2/constants.dart';

// ignore: must_be_immutable
class HeaderTitle extends StatelessWidget {
  Size screenSize;
  String title;
  HeaderTitle({super.key, required this.screenSize, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      width: screenSize.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white70,
            fontSize: 24.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
