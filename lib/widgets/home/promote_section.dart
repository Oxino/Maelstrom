import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/tags_widget.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/base_image.dart';

class PromoteSection extends StatelessWidget {
  // final String eventName;
  // final List<dynamic> eventTags;
  // final String imageURL;
  // PromoteSection(this.eventName, this.eventTags, this.imageURL);

  final QueryDocumentSnapshot<Object?> event;
  PromoteSection(this.event);
  @override
  Widget build(BuildContext context) {
    final Storage _firestoreStorage = Storage();
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
                child: FutureBuilder(
                  future: _firestoreStorage.getImageURL(event['imageName']),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return BaseImage(ImageType.promote, snapshot.data!);
                    }
                    if (snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Container();
                  },
                )),

            // BaseImage(ImageType.promote, imageURL)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(TextType.bodyBoldText, event['name']),
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
                children: event['tags'].map<Widget>((tag) {
              if (event["tags"].indexOf(tag) > 3) return Container();
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
