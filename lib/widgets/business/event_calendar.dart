import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/calendar_event_model.dart';

import 'package:maelstrom/repositories/event/event_repo.dart';

import 'package:maelstrom/models/event_model.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/business/date_item.dart';
import 'package:maelstrom/widgets/business/event_widget.dart';

class EventCalendar extends StatefulWidget {
  final String idBusiness;
  EventCalendar(String this.idBusiness, {Key? key}) : super(key: key);

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  final EventRepos _eventRepos = EventRepos();
  int? currentItemActive = null;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EventModel?>>(
        stream: _eventRepos.getBusinessWeekEvents(widget.idBusiness),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: BaseText(
                TextType.bodyBoldText,
                "Pas d'évènement corespondant a votre recherche",
              ),
            );
          }
          List<CalendarEvent> allCalendarEvent =
              _getDateLabelFormat(snapshot.data!);
          return Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: allCalendarEvent
                              .map<Widget>((CalendarEvent calendarEvent) {
                            return DateItem(
                                calendarEvent: calendarEvent,
                                isActive:
                                    calendarEvent.index == currentItemActive,
                                setOnClick: () =>
                                    _setCurrentItemActive(calendarEvent.index));
                          }).toList()),
                    ],
                  )),
              SizedBox(height: 10),
              currentItemActive != null
                  ? EventWidget(allCalendarEvent[currentItemActive!].event, isToday: currentItemActive! == 0,)
                  : Column(children: [
                      BaseText(TextType.sectionTitle,
                          "Pas d'événement cette semaine"),
                      SizedBox(height: 250),
                    ])
            ],
          ));
        }));
  }

  void _setCurrentItemActive(index) =>
      setState(() => currentItemActive = index);

  List<CalendarEvent> _getDateLabelFormat(events) {
    DateTime currentDate = DateTime.now();
    List<CalendarEvent> allCalendarEvent = [];
    for (var i = 0; i < 7; i++) {
      EventModel? dayEvent = _getDayEvent(events, currentDate);

      String currentDateLabelFr = DateFormat.EEEE('fr_FR').format(currentDate);
      String label =
          "${currentDateLabelFr[0].toUpperCase()}${currentDateLabelFr.substring(1, 3).toLowerCase()}";
      String number = DateFormat.d('fr_FR').format(currentDate);

      allCalendarEvent.add(CalendarEvent(i, label, number, dayEvent));
      currentDate = currentDate.add(const Duration(days: 1));
    }

    if (currentItemActive == null) setFirstEventActive(allCalendarEvent);

    return allCalendarEvent;
  }

  setFirstEventActive(List<CalendarEvent> allCalendarEvent) {
    int? firstEvent;
    for (var i = 0; i < allCalendarEvent.length; i++) {
      if (allCalendarEvent[i].event != null) {
        firstEvent = allCalendarEvent[i].index;
        break;
      } else
        firstEvent = null;
    }
    if (firstEvent != null) {
      currentItemActive = firstEvent;
    }
  }

  EventModel? _getDayEvent(List<EventModel?> events, DateTime currentDate) {
    EventModel? result = null;
    events.forEach((event) {
      String currentDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
      String eventDateFormat =
          DateFormat('dd-MM-yyyy').format(event!.startDate.toDate());
      if (eventDateFormat == currentDateFormat) {
        result = event;
      }
    });
    return result;
  }
}
