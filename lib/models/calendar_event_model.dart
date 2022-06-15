import 'package:maelstrom/models/event_model.dart';

class CalendarEvent {
  final int index;
  final String dateLabel;
  final String dateNumber;
  final EventModel? event;

  CalendarEvent(
    int this.index,
    String this.dateLabel,
    String this.dateNumber,
    EventModel? this.event,
  );
}
