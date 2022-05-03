import 'package:flutter/material.dart';

import '../../config.dart';

import '../../widgets/tags.dart';
import '../baseButton.dart';
import '../baseText.dart';

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
            Container(
              height: 77,
              width: 125,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/image3.jpg',
                    ),
                    fit: BoxFit.cover,
                  )),
              child: null,
            ),
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
                Tags(TagsType.small, "Célibataire", TagsColors.yellowTag),
                SizedBox(width: 5),
                Tags(TagsType.small, "Célibataire", TagsColors.blueTag),
                SizedBox(width: 5),
                Tags(TagsType.small, "Célibataire", TagsColors.purpleTag),
              ],
            ),
            BaseButton(ButtonsType.small),
          ],
        ),
      ]),
    );
  }
}
