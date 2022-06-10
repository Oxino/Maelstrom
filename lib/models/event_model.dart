import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id = "";
  String idBusiness;
  String name;
  String description;
  String imageName;
  List tags;
  Timestamp startDate;
  Timestamp endDate;
  int nbViews = 0;
  int nbReserved = 0;
  int nbGo = 0;
  bool promote;

  EventModel({
    required this.idBusiness,
    required this.name,
    required this.description,
    required this.imageName,
    required this.tags,
    required this.startDate,
    required this.endDate,
    required this.promote,
  });

  // EventModel.fromData(DocumentSnapshot<Object?> data)
  //     : idBusiness = data['idBusiness'],
  //       name = data['name'],
  //       description = data['description'],
  //       tags = data['tags'],
  //       date = data['date'],
  //       promote = data['promote'];

  factory EventModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
    // SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return EventModel(
        idBusiness: data?['idBusiness'],
        name: data?['name'],
        description: data?['description'],
        imageName: data?['imageName'],
        tags: data?['tags'],
        startDate: data?['startDate'],
        endDate: data?['endDate'],
        promote: data?['promote']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "idBusiness": idBusiness,
      "name": name,
      "description": description,
      "imageName": imageName,
      "tags": tags,
      "startDate": startDate,
      "endDate": endDate,
      "promote": promote,
    };
  }

  Map<String, dynamic> toJson() => {
        'idBusiness': idBusiness,
        'name': name,
        'description': description,
        'imageName': imageName,
        'tags': tags,
        'w': startDate,
        'endDate': endDate,
        'promote': promote,
      };
}
