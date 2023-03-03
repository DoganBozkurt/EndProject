import 'package:flutter/material.dart';
import 'package:usis_2/Screen/addJob.dart';
import 'package:usis_2/Screen/home.dart';
import 'package:usis_2/Screen/jobDetail.dart';

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
        HomeScreen.pageName: (context) =>  const HomeScreen(),
        AddJobScreen.pageName: (context) => const AddJobScreen(),
        JobDetail.pageName:(context) => const JobDetail()
        },
    ),
  );

