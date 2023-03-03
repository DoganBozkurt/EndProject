import 'package:flutter/material.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Responsive/tabletView.dart';
import 'package:usis_2/Responsive/webView.dart';

import '../Widget/mobileMenu.dart';
import 'mobileView.dart';

SafeArea responsive(BuildContext context, Size screenSize,bool isLoaded,Widget Function(BuildContext, Size) ekran) {
    return SafeArea(
    child: Scaffold(
      resizeToAvoidBottomInset: false, //keyboard hatasını çözer
      drawer: !ResponsiveUtils.isScreenWeb(context) ? mobileMenu() : null,
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ResponsiveUtils(
          screenWeb: webView(ekran, screenSize, context),
          screenTablet: tabletView(ekran, screenSize, context),
          screenMobile: mobileView(ekran, screenSize, context),
        ),
      ),
    ),
  );
  }