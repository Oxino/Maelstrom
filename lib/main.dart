// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:flutter/semantics.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'config.dart';

import 'pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF236BFE),
        backgroundColor: Color(0xFF181929),

        fontFamily: GoogleFonts.poppins(
          color: ThemeColors.whiteColor,
          fontSize: 14,
        ).fontFamily,

        // textTheme: const TextTheme(
        //    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //   subtitle1: TextStyle(fontSize: 24),
        // )
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mealstrom',
      home: HomePage(),
    );
  }
}