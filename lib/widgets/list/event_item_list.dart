import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';

import 'package:maelstrom/widgets/base_image.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/clickable_event.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class EventItemList extends StatelessWidget {
  final EventModel event;
  EventItemList(this.event);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: ClickableEvent(
            event.idBusiness,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                  color: ThemeColors.grayColor,
                  borderRadius: BorderRadius.all((Radius.circular(10)))),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                BaseImage(ImageType.smallSquare, event.imageName),
                SizedBox(width: 8),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            flex: 5,
                            child: BaseText(TextType.littleBoldText, event.name,
                                textMaxSize: 55)),
                        Flexible(
                            flex: 1,
                            child: BaseText(TextType.littleBoldText, '2km')),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: event.tags.map<Widget>((tag) {
                          if (event.tags.indexOf(tag) > 3) return Container();
                          return TagsWidget(TagsType.small, tag['name'],
                              Color(tag['colorValue']));
                        }).toList()),
                  ],
                )),
              ]),
            )));
  }
}
