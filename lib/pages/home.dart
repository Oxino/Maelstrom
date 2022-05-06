// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/pages/base_page.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';

import 'package:maelstrom/widgets/home/search_section.dart';
import 'package:maelstrom/widgets/home/promote_section.dart';
import 'package:maelstrom/widgets/home/reco_section.dart';

class HomePage extends BasePage {
  HomePage()
      : super(
            appBar: HomeAppBar(),
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
                        child:
                            BaseText(TextType.sectionTitle, "Recomandations"),
                      ),
                      SizedBox(height: 15),
                      RecoSection(),
                      SizedBox(height: 30),
                    ],
                  ),
                )));
}
