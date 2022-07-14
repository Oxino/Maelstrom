// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';
import 'package:maelstrom/widgets/home/promote_section.dart';
import 'package:maelstrom/widgets/home/reco_section.dart';

// class HomePage extends BasePage {
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeAppBar(),
          // SearchSection(),
          SizedBox(height: 20),
          PromoteSection(),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: BaseText(TextType.sectionTitle, "Recomandations"),
          ),
          RecoSection(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
