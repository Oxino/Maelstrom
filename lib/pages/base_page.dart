// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_navigation_bar.dart';

abstract class BasePage extends StatelessWidget {
  // final appBar;
  // final body;
  // BasePage({
  //   required this.appBar,
  //   required this.body,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: buildBar(),
      body: buildBody(),
      bottomNavigationBar: BaseNavigationBar(),
    );
  }

  @protected
  PreferredSizeWidget? buildBar();

  @protected
  Widget? buildBody();
}
