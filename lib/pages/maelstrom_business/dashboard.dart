// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';

// class HomePage extends BasePage {
class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppBar(),
        SingleChildScrollView(
          child: BaseText(TextType.sectionTitle, "Dashboard"),
        )
      ],
    );
  }
}
