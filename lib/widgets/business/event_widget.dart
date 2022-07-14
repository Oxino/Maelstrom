import 'package:flutter/material.dart';
import 'package:maelstrom/models/event_model.dart';

class EventWidget extends StatefulWidget {
  EventModel event;
  EventWidget(this.event, {Key? key}) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
