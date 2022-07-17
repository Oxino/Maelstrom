import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/models/user_model.dart';

abstract class BaseUserRepo {
  Stream<UserModel> getUserById(idUser);
}
