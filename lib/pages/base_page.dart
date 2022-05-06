// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_navigation_bar.dart';

class BasePage extends StatelessWidget {
  final appBar;
  final body;
  BasePage({
    required this.appBar,
    required this.body,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: appBar,
      body: body,
      bottomNavigationBar: BaseNavigationBar(),
    );
  }
}
