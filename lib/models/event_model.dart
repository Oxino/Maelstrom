import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String id = "";
  String idBusiness;
  String name;
  String description;
  Array tags;
  Timestamp date;
  int nbViews = 0;
  int nbReserved = 0;
  int nbGo = 0;
  bool promote;

  EventModel({
    required this.idBusiness,
    required this.name,
    required this.description,
    required this.tags,
    required this.date,
    required this.promote,
  });

  EventModel.fromData(DocumentSnapshot<Object?> data)
      : idBusiness = data['idBusiness'],
        name = data['name'],
        description = data['description'],
        tags = data['tags'],
        date = data['date'],
        promote = data['promote'];

  Map<String, dynamic> toJson() => {
        'idBusiness': idBusiness,
        'name': name,
        'description': description,
        'tags': tags,
        'date': date,
        'promote': promote,
      };
}
