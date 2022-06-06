import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/tags_widget.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/base_image.dart';

class PromoteSection extends StatelessWidget {
  final String eventName;
  final List<dynamic> eventTags;
  final String imageURL;
  PromoteSection(this.eventName, this.eventTags, this.imageURL);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: ThemeColors.grayColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(right: 12),
                child: BaseImage(ImageType.promote, imageURL)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(TextType.bodyBoldText, eventName),
                SizedBox(height: 10),
                BaseText(TextType.littleText, 'Lieu'),
              ],
            ))
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                children: eventTags.map<Widget>((tag) {
              if (eventTags.indexOf(tag) > 3) return Container();
              return TagsWidget(
                  TagsType.small, tag['name'], Color(tag['colorValue']));
            }).toList()),
            BaseButton(ButtonsType.small, () {}, "Voir", [
              ThemeColors.principaleBusinessColor,
              ThemeColors.radientBusinessColor
            ]),
          ],
        ),
      ]),
    );
  }
}
