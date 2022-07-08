// import '';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/event/event_repo.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/home/promote_section.dart';

class BusinessListEventPage extends StatelessWidget {
  // final FirestoreService _firestoreService = FirestoreService();
  final EventRepos _eventRepos = EventRepos();
  String idBusiness = FirebaseAuth.instance.currentUser!.uid;

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
                child: StreamBuilder<List<EventModel>>(
                    stream: _eventRepos.getBusinessEvents(idBusiness),
                    builder: ((context, snapshot) {
                      if (!snapshot.hasData) {
                        return LinearProgressIndicator();
                      }
                      return Column(
                          children: snapshot.data!.map((event) {
                        String eventDate = DateFormat('dd MM yyyy')
                            .format(event.startDate.toDate());
                        return Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BaseText(TextType.sectionTitle, eventDate),
                                  SizedBox(height: 10),
                                  PromoteSection(event),
                                ]));
                      }).toList());
                    }))))
      ],
    );
  }
}
