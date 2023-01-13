// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Screen/home.dart';

Widget mobileView(Size screenSize, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: screenSize.width > ResponsiveUtils.tabletWidthLimit ? 5 : 8,
        child: jobsListView(context, screenSize),
      ),
    ],
  );
}
