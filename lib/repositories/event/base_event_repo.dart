import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/event_model.dart';

abstract class BaseEventRepo {
  Stream<List<EventModel>> getAllEvents();
  Stream<List<EventModel>> getBusinessEvents(String idBusiness);
  Stream<List<EventModel?>> getBusinessWeekEvents(String idBusiness);
  Stream<EventModel?> geEventById(String idEvent);
  // List<double> getNumeberBusinnessEventsByMonth (String idBusiness);

  // QueryDocumentSnapshot<EventModel?> getBestMounthBusinesEvents(List activeTags);
  Stream<List<EventModel?>> getTodayEvents(List activeTags);
  Stream<List<EventModel?>> getTodayPromoteEvents();
}
