import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kPrimaryColor = Color(0xff333951);
const kContentColor = Color.fromRGBO(33, 35, 50, 1);

const constUrl = "https://02f0-149-140-200-150.eu.ngrok.io";

Divider diveder() {
  return const Divider(
    height: 5,
    color: Color.fromARGB(241, 255, 193, 7),
  );
}

AwesomeDialog logOutDialog(
    BuildContext context, String title, String desc, DialogType sorun) {
  return AwesomeDialog(
      btnCancelText: "İPTAL",
      btnCancelColor: Colors.blue,
      btnOkText: "ÇIK",
      btnOkColor: Colors.red,
      dialogBackgroundColor: kPrimaryColor,
      context: context,
      dialogType: sorun,
      width: 500,
      borderSide: const BorderSide(color: Colors.green, width: 2),
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.leftSlide,
      title: title,
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      desc: desc,
      descTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0);
        }
      });
}

Future islemDialog(
    BuildContext context, String title, String desc, DialogType sorun) {
  return AwesomeDialog(
          btnCancelText: "TAMAM",
          btnCancelColor: Colors.blue,
          btnOkColor: Colors.red,
          dialogBackgroundColor: kPrimaryColor,
          context: context,
          dialogType: sorun,
          width: 500,
          borderSide: const BorderSide(color: Colors.green, width: 2),
          buttonsBorderRadius: const BorderRadius.all(Radius.circular(2)),
          headerAnimationLoop: false,
          animType: AnimType.leftSlide,
          title: title,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          desc: desc,
          descTextStyle: const TextStyle(color: Colors.white),
          showCloseIcon: true,
          btnOkOnPress: () {})
      .show();
}

eksikBilgi(BuildContext context, String alan) {
  islemDialog(context, "Eksik Bilgi",
      "$alan bilgisini girniz ve tekrar deneyiniz!", DialogType.info);
}
