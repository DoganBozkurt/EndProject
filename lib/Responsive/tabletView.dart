// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Screen/home.dart';
import 'package:usis_2/Widget/leftMenu.dart';

Widget tabletView(Size screenSize, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          flex: screenSize.width > ResponsiveUtils.tabletWidthLimit ? 1 : 2,
          child: leftMenu()),
      Expanded(
          flex: screenSize.width > ResponsiveUtils.tabletWidthLimit ? 7 : 9,
          child: jobsListView(context, screenSize)),
    ],
  );
}