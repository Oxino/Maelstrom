// import 'dart:html';

import 'package:flutter/material.dart';

import '../widgets/home/homeAppBar.dart';
import '../widgets/baseNavigationBar.dart';

import '../widgets/baseText.dart';
import '../config.dart';

class MapPage extends StatelessWidget {
  int pageIndex = 3;
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   backgroundColor: ThemeColors.backgroundColor,
        //   appBar: HomeAppBar(),
        //   body:
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BaseText(TextType.sectionTitle, "Map Page"),
                ],
              ),
            ));
    // bottomNavigationBar: BaseNavigationBar(pageIndex),
    // );
  }
}
