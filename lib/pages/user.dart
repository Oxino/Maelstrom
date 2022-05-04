// import 'dart:html';

import 'package:flutter/material.dart';

import '../widgets/baseNavigationBar.dart';
import '../widgets/titleAppBar.dart';
import '../widgets/baseText.dart';
import '../config.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: TitleAppBar('User'),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BaseText(TextType.sectionTitle, "User Page"),
              ],
            ),
          )),
      // bottomNavigationBar: BaseNavigationBar(4),
    );
  }
}
