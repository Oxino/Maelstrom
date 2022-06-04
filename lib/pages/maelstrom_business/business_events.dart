// import '';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/widgets/home/promote_section.dart';

class BusinessEventPage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();
  final Storage _firestoreStorage = Storage();
  var businessId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    // getEvent();
    // return Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 30),
    //     child: SingleChildScrollView(
    //         child: StreamBuilder<QuerySnapshot>(
    //             stream: _firestoreService.getAllBusinessEvent(businessId),
    //             builder: ((context, snapshot) {
    //               if (!snapshot.hasData) return LinearProgressIndicator();
    //               return Column(
    //                   children: snapshot.data!.docs.map((event) {;
    //                 return Padding(
    //                   child: PromoteSection(event['name'], event['tags']),
    //                   padding: EdgeInsets.only(bottom: 20),
    //                 );
    //               }).toList());
    //             }))));
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("events")
                    .where("idBusiness", isEqualTo: businessId)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) return LinearProgressIndicator();
                  return Column(
                      children: snapshot.data!.docs.map((event) {
                    ;
                    return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: FutureBuilder(
                          future:
                              _firestoreStorage.getImagURL(event['imageName']),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              print(snapshot.data!);
                              return PromoteSection(
                                  event['name'], event['tags'], snapshot.data!);
                            }
                            if (snapshot.hasData ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return Container();
                          },
                        ));
                  }).toList());
                }))));
  }
}
