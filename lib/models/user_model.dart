import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final Timestamp birthDate;
  final String email;
  List<dynamic> favorite = [];

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.birthDate,
      required this.email,
      this.favorite = const []});

  static UserModel formSnapshot(DocumentSnapshot snap) {
    UserModel user = UserModel(
      id: snap['id'],
      firstName: snap['firstName'],
      lastName: snap['lastName'],
      birthDate: snap['birthDate'],
      email: snap['email'],
      favorite: snap['favorite'],
    );

    return user;
  }

  UserModel.fromData(DocumentSnapshot<Object?> data)
      : id = data['id'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        birthDate = data['birthDate'],
        email = data['email'],
        favorite = data['favorite'];

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          firstName: json['firstName']! as String,
          lastName: json['lastName']! as String,
          birthDate: json['birthDate']! as Timestamp,
          email: json['email']! as String,
          favorite: json['favorite']! as List<dynamic>,
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'birthDate': birthDate,
        'email': email,
        'favorite': favorite,
      };
}
