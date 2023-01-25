import 'package:flutter/material.dart';
import 'package:usis_2/Screen/addJob.dart';
import 'package:usis_2/Screen/home.dart';

void main() 
  =>runApp(
    MaterialApp(
      title: 'E N D 4.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.pageName,
      routes: {
        HomeScreen.pageName: (context) =>  HomeScreen(),
        AddJobScreen.pageName: (context) => const AddJobScreen()
        },
    ),
  );

