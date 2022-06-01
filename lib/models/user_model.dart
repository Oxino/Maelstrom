import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  List<String> favorite = [];

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      favorite});

  UserModel.fromData(DocumentSnapshot<Object?> data)
      : id = data['id'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        email = data['email'],
        favorite = data['favorite'];

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          firstName: json['firstName']! as String,
          lastName: json['lastName']! as String,
          email: json['email']! as String,
          favorite: json['favorite']! as List<String>,
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'favorite': favorite,
      };
}
