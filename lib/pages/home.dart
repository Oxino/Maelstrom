// import 'dart:html';

import 'package:flutter/material.dart';

import '../widgets/home/searchSection.dart';
import '../widgets/home/promoteSection.dart';
import '../widgets/home/recoSection.dart';
import '../widgets/baseAppBar.dart';

import '../widgets/baseText.dart';
import '../config.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: BaseAppBar(),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchSection(),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BaseText(
                        TextType.sectionTitle, "Evènement de la soirée"),
                  ),
                  SizedBox(height: 15),
                  PromoteSection(),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BaseText(TextType.sectionTitle, "Recomandations"),
                  ),
                  SizedBox(height: 15),
                  RecoSection(),
                  SizedBox(height: 30),
                ],
              ),
            )));
  }
}
