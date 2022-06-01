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
      print("Echec de la récupération de l'utilisateur business: $e");
    }
  }

  Future getBusinessEvent(business_id) async {
// List<DocumentSnapshot> docs;
// await _eventCollectionReference
// ..where("isBusiness",isEqualTo: business_id)
// .getDocuments().then((query) {
//     docs = query.documents;
// });
// print("DOCS: $docs");

    // final ref = _eventCollectionReference
    //     .where("idBusiness", isEqualTo: business_id)
    //     .orderBy("date")
    //     .withConverter(
    //       fromFirestore: EventModel.fromFirestore,
    //       toFirestore: (EventModel event, _) => event.toFirestore(),
    //     );
    // final docSnap = await ref.get();
    // final event = docSnap.docs; // Convert to City object
    // if (event != null) {
    //   print(event);
    // } else {
    //   print("No such document.");
    // }
    // ;
    // var events = [];
    // _eventCollectionReference.where("idBusiness", isEqualTo: business_id).orderBy("date").get().then((snapshot) => {
    //   print(snapshot),
    //   print(snapshot.docs),

    //   snapshot.docs.forEach((doc) => {
    //     EventModel.fromFirestore(doc);
    // final event = doc.data(),
    // print(event),
    // event.userRef.get().then((snap) => {
    //   event.user = snap.data()
    //   events.add(doc),
    //   print(events),
    // })
    //   })
    // }
    // )},

    // print(events)

    //   //   (QuerySnapshot doc) {
    //   //     final data = doc.data() as Map<String, dynamic>;
    //   //   },
    //   //   onError: (e) => print("Error getting document: $e"),
    //   // );
  }
}
