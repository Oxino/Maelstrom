import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';

class DataBox extends StatelessWidget {
  final String title;
  final int value;
  final String svgLink;
  DataBox(String this.title, int this.value, String this.svgLink);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: ThemeColors.grayColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: SizedBox(
                  height: 30, // Your Height
                  width: 30,
                  child: SvgPicture.asset(
                    svgLink,
                  )),
            ),
            BaseText(TextType.bigText, title),
          ],
        ),
        SizedBox(height: 10),
        BaseText(TextType.megaTitle, value.toString()),
      ]),
    );
  }
}
