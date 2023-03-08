import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const  kPrimaryColor = Color(0xff333951);
const kContentColor = Color.fromRGBO(33, 35, 50, 1);
const constUrl="https://b657-176-55-157-82.eu.ngrok.io";
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
      title: title,titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20),
      desc: desc,descTextStyle: const TextStyle(color: Colors.white),
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
      title: title,titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20),
      desc: desc,descTextStyle: const TextStyle(color: Colors.white),
      showCloseIcon: true,
      btnOkOnPress: () {
      }).show();
}
