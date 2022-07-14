import 'package:flutter/material.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_image.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class EventWidget extends StatefulWidget {
  EventModel? event;
  EventWidget(this.event, {Key? key}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    bool hasSelectedEvent = widget.event != null;
    if (hasSelectedEvent) {
      EventModel event = widget.event!;
      return Container(
          padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: ThemeColors.grayColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseImage(ImageType.big, event.imageName),
              SizedBox(height: 10),
              BaseText(TextType.pageTitle, event.name),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: event.tags.map<Widget>((tag) {
                    if (event.tags.indexOf(tag) > 3) return Container();
                    return TagsWidget(
                        TagsType.big, tag['name'], Color(tag['colorValue']));
                  }).toList()),
              SizedBox(height: 15),
              BaseText(TextType.bodyText, event.description),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BaseText(TextType.bigText, '2km'),
                  BaseButton(ButtonsType.big, () {})
                ],
              )
            ],
          ));
    }
    return Container();
  }
}
