// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:usis_2/Responsive/mobileView.dart';
import 'package:usis_2/Responsive/responsive_utils.dart';
import 'package:usis_2/Responsive/tabletView.dart';
import 'package:usis_2/Responsive/webView.dart';
import 'package:usis_2/constants.dart';

import '../Widget/mobileMenu.dart';
class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});
 static const String pageName = "/AddJobScreen";
  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  
TextEditingController adet = TextEditingController();
TextEditingController fiyat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //keyboard hatasını çözer
        drawer: !ResponsiveUtils.isScreenWeb(context) ? mobileMenu() : null,
        body: ResponsiveUtils(
          screenWeb: webView(deneme,screenSize, context),
          screenTablet: tabletView(deneme,screenSize, context),
          screenMobile: mobileView(deneme,screenSize, context),
        ),
      ),
    );
  }


 Widget deneme(final BuildContext context, Size screenSize) => Column(
         mainAxisAlignment: MainAxisAlignment.center,
         mainAxisSize: MainAxisSize.min,
         children: [
           const Text(
             "iş ekleme paneli",
             style: TextStyle(color: kPrimaryColor, fontSize: 18),
           ),
           adetFiyatTextField("Personel", adet),
           adetFiyatTextField("Ürün Bilgileri", fiyat),
         ],
       
     );
}

Padding adetFiyatTextField(String hint, TextEditingController kontroler) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: kontroler,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(25),
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
      ),
    ),
  );
}
