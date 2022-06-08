// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';
import 'package:maelstrom/widgets/home/search_section.dart';
import 'package:maelstrom/widgets/home/promote_section.dart';
import 'package:maelstrom/widgets/home/reco_section.dart';

// class HomePage extends BasePage {
class HomePage extends StatelessWidget {
  final event = {
    'title': 'Soirée célib : Faites des rencontre',
    'place': 'La casa',
    'picture': 'assets/images/image1.jpg',
    'km': '1km',
    'tag': [],
  };
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeAppBar(),
          SizedBox(height: 20),
          // SearchSection(),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: BaseText(TextType.sectionTitle, "Evènement de la soirée"),
          ),
          SizedBox(height: 15),
          // PromoteSection(event),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerLeft,
            child: BaseText(TextType.sectionTitle, "Recomandations"),
          ),
          SizedBox(height: 15),
          // RecoSection(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
