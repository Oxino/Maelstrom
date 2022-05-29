import 'package:cloud_firestore/cloud_firestore.dart';

class Business {
  String id;
  String institutionName;
  String siret;
  String address;
  String description;
  String firstName;
  String lastName;
  String email;

  Business({
    required this.id,
    required this.institutionName,
    required this.siret,
    required this.address,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Business.fromData(DocumentSnapshot<Object?> data)
      : id = data['id'],
        institutionName = data['institutionName'],
        siret = data['siret'],
        address = data['address'],
        description = data['description'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        email = data['email'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'institutionName': institutionName,
        'siret': siret,
        'address': address,
        'description': description,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      };
}
