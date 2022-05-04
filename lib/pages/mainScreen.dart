// import 'dart:html';

import 'package:flutter/material.dart';

import '../widgets/home/homeAppBar.dart';
import '../widgets/baseNavigationBar.dart';

import 'home.dart';
import 'list.dart';
import 'map.dart';

import '../config.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State {
   final _pageController = PageController(initialPage: 0);
  int _selectedPage = 0;
  List pageList = [
    HomePage(),
    ListPage(),
    MapPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      backgroundColor: ThemeColors.backgroundColor,
      body: PageView(
          controller: _pageController,
          // Repaint screen on page change
          onPageChanged: (value) => setState(() => _selectedPage = value), children: [pageList[0]]),
      bottomNavigationBar: BaseNavigationBar(_pageController, _selectedPage),

    );
  }
}
