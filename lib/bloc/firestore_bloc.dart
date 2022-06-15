import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/user_model.dart';
import 'package:maelstrom/models/event_model.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _businessUsersCollectionReference =
      FirebaseFirestore.instance.collection("business_users");
  final CollectionReference _eventCollectionReference =
      FirebaseFirestore.instance.collection("events");

  final uersRef = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (users, _) => users.toJson(),
      );
  final businessRef = FirebaseFirestore.instance
      .collection('business')
      .withConverter<BusinessModel>(
        fromFirestore: (snapshot, _) =>
            BusinessModel.fromJson(snapshot.data()!),
        toFirestore: (business, _) => business.toJson(),
      );

  Future createUser(UserModel user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      print("Echec de la création de l'utilisateur : $e");
    }
  }

  // Future getUser(bool isBusiness, String id) async {
  //   return isBusiness
  //       ? await businessRef.doc(id).get().then((snapshot) => snapshot.data()!)
  //       : await uersRef.doc(id).get().then((snapshot) => snapshot.data()!);
  // }

  Future getUser(bool isBusiness, String id) async {
    try {
      if (isBusiness) {
        var userData = await _businessUsersCollectionReference.doc(id).get();
        print(userData);
        return BusinessModel.fromData(userData);
      } else {}
      var userData = await _usersCollectionReference.doc(id).get();
      print(userData);
      return UserModel.fromData(userData);
    } catch (e) {
      print("Echec de la récupération de l'utilisateur: $e");
    }
  }

  Future createBusinessUser(BusinessModel businessUser) async {
    try {
      await _businessUsersCollectionReference
          .doc(businessUser.id)
          .set(businessUser.toJson());
    } catch (e) {
      print("Echec de la création de l'utilisateur business: $e");
    }
  }

  Future createEvent(EventModel event) async {
    try {
      await _eventCollectionReference.doc().set(event.toJson());
    } catch (e) {
      print("Echec de la création de l'évènement: $e");
    }
  }

  Stream<QuerySnapshot<Object?>>? getAllBusinessEvent(business_id) {
    return _eventCollectionReference
        .where("idBusiness", isEqualTo: business_id)
        .snapshots();
  }

  // Future getBusinessEvent(business_id) async {
  //   final ref = _eventCollectionReference
  //                   .where("idBusiness", isEqualTo: business_id).withConverter(
  //         fromFirestore: EventModel.fromFirestore,
  //         toFirestore: (EventModel event, _) => event.toFirestore(),
  //       );
  //   final docSnap = await ref.get();
  //   final event = docSnap.doc().data(); // Convert to City object
  //   if (event != null) {
  //     return event;
  //     print(event);
  //   } else {
  //     print("No such document.");
  //   }
  // }

  Stream<QuerySnapshot<Object?>>? getEventForUser(tagFilter) {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp startDateLimit =
        Timestamp.fromDate(DateTime.now().add(const Duration(hours: 4)));
    print(now.toDate());
    print(startDateLimit.toDate());

    final eventsRef = FirebaseFirestore.instance.collection("events");
    eventsRef.where('startDate', isLessThan: startDateLimit);
    eventsRef.where('endDate', isLessThan: now);
    if (tagFilter.length > 0) {
      eventsRef.where('tags', arrayContains: tagFilter);
    }

    return eventsRef.snapshots();
  }
}
