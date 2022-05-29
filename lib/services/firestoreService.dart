import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/business.dart';
import 'package:maelstrom/models/curent_user.dart';
import 'package:maelstrom/models/event_model.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _businessUsersCollectionReference =
      FirebaseFirestore.instance.collection("business_users");
  final CollectionReference _eventCollectionReference =
      FirebaseFirestore.instance.collection("events");

  Future createUser(CurentUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future getUser(bool isBusiness, String id) async {
    try {
      if (isBusiness) {
        var userData = await _businessUsersCollectionReference.doc(id).get();
        print(userData);
        return Business.fromData(userData);
      } else {}
      var userData = await _usersCollectionReference.doc(id).get();
      print(userData);
      return CurentUser.fromData(userData);
    } catch (e) {
      print(e);
    }
  }

  Future createBusinessUser(Business businessUser) async {
    try {
      await _businessUsersCollectionReference
          .doc(businessUser.id)
          .set(businessUser.toJson());
    } catch (e) {
      print(e);
    }
  }

  Future createEvent(EventModel event) async {
    try {
      await _eventCollectionReference.doc().set(event.toJson());
    } catch (e) {
      print(e);
    }
  }
}
