import 'package:cloud_firestore/cloud_firestore.dart';

class CurentUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  List<String> favorite = [];

  CurentUser(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      favorite});

  CurentUser.fromData(DocumentSnapshot<Object?> data)
      : id = data['id'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        email = data['email'],
        favorite = data['favorite'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'favorite': favorite,
      };
}
