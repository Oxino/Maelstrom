import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';

import 'package:maelstrom/widgets/tags_widget.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/base_image.dart';

class PromoteWidget extends StatelessWidget {
  // final String eventName;
  // final List<dynamic> eventTags;
  // final String imageURL;
  // PromoteSection(this.eventName, this.eventTags, this.imageURL);

  final EventModel event;
  final bool isBusiness;
  final BusinessRepo _businessRepos = BusinessRepo();

  PromoteWidget(EventModel this.event, {bool this.isBusiness = false});
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
                child: BaseImage(ImageType.promote, event.imageName)),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(TextType.bodyBoldText, event.name),
                if (!isBusiness) SizedBox(height: 10),
                if (!isBusiness)
                  StreamBuilder<BusinessModel?>(
                      stream:
                          _businessRepos.getCurrentBusiness(event.idBusiness),
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData)
                          return BaseText(
                              TextType.littleText, "Pas d'établissement",
                              textMaxSize: 30);
                        return BaseText(
                            TextType.littleText, snapshot.data!.institutionName,
                            textMaxSize: 30);
                      })),
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
                children: event.tags.map<Widget>((tag) {
              if (event.tags.indexOf(tag) > 3) return Container();
              return TagsWidget(
                  TagsType.small, tag['name'], Color(tag['colorValue']));
            }).toList()),
            isBusiness
                ? BaseButton(ButtonsType.small, () {}, "Voir",
                    [ThemeColors.principaleColor, ThemeColors.radientColor])
                : BaseButton(ButtonsType.small, () {}, "Y aller",
                    [ThemeColors.principaleColor, ThemeColors.radientColor]),
          ],
        ),
      ]),
    );
  }
}
