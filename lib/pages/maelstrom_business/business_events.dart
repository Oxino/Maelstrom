// import '';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';

import 'package:maelstrom/widgets/home/promote_section.dart';

class BusinessEventPage extends StatelessWidget {
  // final FirestoreService _firestoreService = FirestoreService();
  String businessId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Timestamp now = Timestamp.fromDate(DateTime.now());
    return Column(
      children: [
        BaseAppBar(
          textBar: 'Vos évènements',
          rightIcon: 'assets/icons/plus.svg',
          rightIconFuction: PageType.createEvent,
        ),
        SizedBox(height: 20),
        Expanded(
            child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("events")
                        .where("idBusiness", isEqualTo: businessId)
                        .orderBy("startDate")
                        .startAfter([now]).snapshots(),
                    builder: ((context, snapshot) {
                      print(snapshot);
                      if (!snapshot.hasData) return LinearProgressIndicator();
                      return Column(
                          children: snapshot.data!.docs.map((event) {
                        return Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: PromoteSection(event));
                      }).toList());
                    }))))
      ],
    );
  }
}
