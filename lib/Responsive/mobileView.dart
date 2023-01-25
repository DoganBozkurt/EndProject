// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';

Widget mobileView(Widget Function(BuildContext context,Size screenSize) ekran,Size screenSize, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: screenSize.width > ResponsiveUtils.tabletWidthLimit ? 5 : 8,
        child: ekran(context, screenSize),
      ),
    ],
  );
}
