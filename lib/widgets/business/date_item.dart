import 'package:flutter/material.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/calendar_event_model.dart';
import 'package:maelstrom/widgets/base_text.dart';

class DateItem extends StatefulWidget {
  final CalendarEvent calendarEvent;
  final bool isActive;
  final VoidCallback setOnClick;
  DateItem(
      {Key? key,
      required CalendarEvent this.calendarEvent,
      required bool this.isActive,
      required VoidCallback this.setOnClick})
      : super(key: key);

  @override
  State<DateItem> createState() => _DateItemState();
}

class _DateItemState extends State<DateItem> {
  @override
  Widget build(BuildContext context) {
    final bool haveEvent = widget.calendarEvent.event != null;
    print(haveEvent);
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: haveEvent
                ? BoxDecoration(
                    color: TagsColors.yellowTag,
                    borderRadius: BorderRadius.all(Radius.circular(10)))
                : null,
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
              onTap: () => widget.setOnClick(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: widget.isActive
                    ? BoxDecoration(
                        borderRadius: new BorderRadius.all(Radius.circular(10)),
                        color: ThemeColors.grayColor,
                      )
                    : null,
                child: Column(
                  children: [
                    BaseText(
                        TextType.bodyBoldText, widget.calendarEvent.dateLabel),
                    SizedBox(
                      height: 3,
                    ),
                    BaseText(
                        TextType.bodyBoldText, widget.calendarEvent.dateNumber),
                  ],
                ),
              ))
        ]);
  }
}
