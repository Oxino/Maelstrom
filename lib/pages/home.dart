// import 'dart:html';

import 'package:flutter/material.dart';

import '../widgets/home/searchSection.dart';
import '../widgets/home/promoteSection.dart';
import '../widgets/home/recoSection.dart';
import '../widgets/myAppBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: MyAppBar(),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SearchSection(),
                  PromoteSection(),
                  RecoSection(),
                  TestGrid(),
                ],
              ),
            )));
  }
}
