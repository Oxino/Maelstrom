import 'dart:async';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:rxdart/rxdart.dart';

class EventBloc implements BlocBase {
  // PageType _page = PageType.home;

  BehaviorSubject<EventModel> _eventController = BehaviorSubject<EventModel>();
  StreamSink<EventModel> get sinkEvent => _eventController.sink;
  Stream<EventModel> get streamEvent => _eventController.stream;

  setEvent(EventModel event) {
    sinkEvent.add(event);
  }

  void dispose() {
    _eventController.close();
  }
}
