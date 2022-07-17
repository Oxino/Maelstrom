import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessModel {
  String id;
  String institutionName;
  String siret;
  String address;
  String description;
  String firstName;
  String lastName;
  String email;

  BusinessModel({
    required this.id,
    required this.institutionName,
    required this.siret,
    required this.address,
    required this.description,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  static BusinessModel formSnapshot(DocumentSnapshot snap) {
    BusinessModel business = BusinessModel(
        id: snap['id'],
        institutionName: snap['institutionName'],
        siret: snap['siret'],
        address: snap['address'],
        description: snap['description'],
        firstName: snap['firstName'],
        lastName: snap['lastName'],
        email: snap['email']);

    return business;
  }

  BusinessModel.fromData(DocumentSnapshot<Object?> data)
      : id = data['id'],
        institutionName = data['institutionName'],
        siret = data['siret'],
        address = data['address'],
        description = data['description'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        email = data['email'];

  BusinessModel.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as String,
            institutionName: json['institutionName']! as String,
            siret: json['siret']! as String,
            address: json['address']! as String,
            description: json['description']! as String,
            firstName: json['firstName']! as String,
            lastName: json['lastName']! as String,
            email: json['email']! as String);

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
