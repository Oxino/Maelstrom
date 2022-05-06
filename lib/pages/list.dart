// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/pages/base_page.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/base_app_bar.dart';

class ListPage extends BasePage {
  ListPage()
      : super(
            appBar: BaseAppBar('test'),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BaseText(TextType.sectionTitle, "Liste Page"),
                    ],
                  ),
                )));
}
