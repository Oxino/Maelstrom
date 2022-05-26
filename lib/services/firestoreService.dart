import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/curent_user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");

  Future createUser(CurentUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      print(e);
    }
  }

  // Future getUser(String id) async {
  //   try {
  //     var userData = await _usersCollectionReference.doc(id).get();
  //     return CurentUser.fromData(userData.data);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
