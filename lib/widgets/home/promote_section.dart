import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/tags_widget.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/base_image.dart';

class PromoteSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 8, top: 8, left: 8, bottom: 15),
      decoration: BoxDecoration(
          color: ThemeColors.grayColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 12),
                child:
                    BaseImage(ImageType.promote, 'assets/images/image3.jpg')),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BaseText(TextType.bodyBoldText,
                    "Soirée célib! Faites des rencontres!"),
                SizedBox(height: 10),
                BaseText(TextType.littleText, "La casa"),
              ],
            ))
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                TagsWidget(TagsType.small, "Célibataire", TagsColors.yellowTag),
                SizedBox(width: 5),
                TagsWidget(TagsType.small, "Célibataire", TagsColors.blueTag),
                SizedBox(width: 5),
                TagsWidget(TagsType.small, "Célibataire", TagsColors.purpleTag),
              ],
            ),
            BaseButton(ButtonsType.small, () {}),
          ],
        ),
      ]),
    );
  }
}
