// ignore_for_file: unused_import, duplicate_ignore

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:scheduler/screens/CoursePage.dart';
import 'package:scheduler/screens/addCourses.dart';
import 'package:scheduler/screens/homeScreen.dart';
import 'package:scheduler/screens/login.dart';
import 'package:scheduler/screens/welcome.dart';
import 'package:scheduler/utils/routes.dart';
import 'package:scheduler/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';



void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      theme: Themes.myTheme,
      routes:{
        routes.courseRoute:(context)=>CoursePage(),
        routes.editRoute:(context)=>AddCourse(),
        routes.homeRoute:(context)=>Home(),

      }

    );
  }
}


