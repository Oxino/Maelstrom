import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/models/user_model.dart';
import 'package:maelstrom/repositories/user/base_user_repo.dart';

class UserRepo extends BaseUserRepo {
  final FirebaseFirestore _firebaseFirestore;
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection("users");

  UserRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<UserModel> getUserById(idUser) {
    return _userCollectionReference
        .doc(idUser)
        .snapshots()
        .map((snapshot) => UserModel.formSnapshot(snapshot));
  }
}
