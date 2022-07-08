import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/event/base_event_repo.dart';

class EventRepos extends BaseEventRepo {
  final FirebaseFirestore _firebaseFirestore;
  final CollectionReference _eventCollectionReference =
      FirebaseFirestore.instance.collection("events");

  EventRepos({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<EventModel>> getAllEvents() {
    return _eventCollectionReference.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.formSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<EventModel>> getBusinessEvents(String idBusiness) {
    return _eventCollectionReference
        .where('isBusiness', isEqualTo: idBusiness)
        .orderBy("startDate")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.formSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<EventModel?>> getBusinessWeekEvents(String idBusiness) {
    Timestamp now = Timestamp.fromDate(DateTime.now());
    Timestamp week =
        Timestamp.fromDate(DateTime.now().add(const Duration(days: 7)));

    Query<Object?> eventsQuery =
        _eventCollectionReference.where('startDate', isLessThan: week);
    eventsQuery = eventsQuery.where('idBusiness', isEqualTo: idBusiness);
    return eventsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        if (now.compareTo(doc['endDate']) > 1) {
          print('hello $doc');
          return EventModel.formSnapshot(doc);
        }
      }).toList();
    });
  }

  @override
  Stream<EventModel?> geEventById(String id) {
    return _eventCollectionReference
        .doc(id)
        .snapshots()
        .map((snapshot) => EventModel.formSnapshot(snapshot));
  }

  @override
  Stream<List<EventModel?>> getTodayEvents(List activeTags) {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp startDateLimit =
        Timestamp.fromDate(DateTime.now().add(const Duration(hours: 4)));
    bool isEventInProgress;
    bool isEventVisible;

    Query<Object?> eventsQuery =
        _eventCollectionReference.where('endDate', isGreaterThan: now);
    if (activeTags.length > 0) {
      eventsQuery = eventsQuery.where('tags', arrayContainsAny: activeTags);
    }

    return eventsQuery.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //Check if event is in progress
        isEventInProgress = now.compareTo(doc['startDate']) > 0 &&
            now.compareTo(doc['endDate']) < 0;
        //If event in progress we waite the endDate to hide
        //If is not in progress we hide all event who start in 4 hour
        isEventVisible = isEventInProgress
            ? now.compareTo(doc['endDate']) < 0
            : startDateLimit.compareTo(doc['startDate']) > 0;
        if (isEventVisible) {
          return EventModel.formSnapshot(doc);
        }
      }).toList();
    });
  }
}
