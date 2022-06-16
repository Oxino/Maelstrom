import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/calendar_event_model.dart';

import 'package:maelstrom/repositories/event/event_repo.dart';

import 'package:maelstrom/models/event_model.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/business/date_item.dart';

class EventCalendar extends StatefulWidget {
  final String idBusiness;
  EventCalendar(String this.idBusiness, {Key? key}) : super(key: key);

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  final EventRepos _eventRepos = EventRepos();
  int currentItemActive = 0;
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
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: allCalendarEvent.map<Widget>((calendarEvent) {
                    return DateItem(
                        calendarEvent: calendarEvent,
                        isActive: calendarEvent.index == currentItemActive,
                        setOnClick: () =>
                            _setCurrentItemActive(calendarEvent.index));
                  }).toList()));
        }));
  }

  void _setCurrentItemActive(item) => setState(() => currentItemActive = item);

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
    return allCalendarEvent;
  }

  EventModel? _getDayEvent(List<EventModel?> events, DateTime currentDate) {
    return events.firstWhere((event) {
      if (event == null) {
        return false;
      }
      String currentDateFormat = DateFormat('dd-MM-yyyy').format(currentDate);
      String eventDateFormat =
          DateFormat('dd-MM-yyyy').format(event.startDate.toDate());
      return eventDateFormat == currentDateFormat;
    }, orElse: () => null);
  }
}
