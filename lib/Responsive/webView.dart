// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:usis_2/NavigationBar/NavigationBar.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';

Widget webView(Widget Function(BuildContext context,Size screenSize) ekran,Size screenSize, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          flex: screenSize.width > ResponsiveUtils.tabletWidthLimit ? 1 : 2,
          child: const NavigationBarr(),),
      Expanded(
          flex: screenSize.width > ResponsiveUtils.tabletWidthLimit ? 11 : 11,
          child: ekran(context, screenSize)),
    ],
  );
}
