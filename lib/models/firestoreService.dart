// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreService {
//   final CollectionReference _usersCollectionReference =
//       Firestore.instance.collection("users");
//   Future createUser(User user) async {
//     try {
//       await _usersCollectionReference.domcument(user.id).setData(user.toJson());
//     } catch (e) {
//       return e.message;
//     }
//   }
// }