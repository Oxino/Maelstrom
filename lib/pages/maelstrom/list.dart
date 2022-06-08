// import '';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/tags_widget.dart';
import 'package:maelstrom/widgets/base_image.dart';

class ListPage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();
  // final List eventList = [
  //   {
  //     'title':
  //         'Soirée célib : Faites des rencontre bla blab labfnzzkljj oimf zehsoa lfn ejijk bavamk aoieflefk njf ',
  //     'place': 'La casacasa casacasa casa casacasacasac ',
  //     'picture': 'assets/images/image1.jpg',
  //     'km': '1km',
  //     'tag': [],
  //   },
  //   {
  //     'title': 'Tournois Super Smash Bros Ulitimate',
  //     'place': 'Le R4dom',
  //     'picture': 'assets/images/image2.jpg',
  //     'km': '1.5km',
  //     'tag': [],
  //   },
  //   {
  //     'title': 'Soirée aèvec DJ Snake  1 conso offerte',
  //     'place': 'La plage',
  //     'picture': 'assets/images/image3.jpg',
  //     'km': '2km',
  //     'tag': [],
  //   },
  //   {
  //     'title': 'Soirée Beer Pong',
  //     'place': 'La Grange',
  //     'picture': 'assets/images/image2.jpg',
  //     'km': '2km',
  //     'tag': [],
  //   },
  //   {
  //     'title': 'Rencontre Geek',
  //     'place': 'Le Sherlock',
  //     'picture': 'assets/images/image1.jpg',
  //     'km': '2.5km',
  //     'tag': [],
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final Timestamp now = Timestamp.fromDate(DateTime.now());
    final Timestamp startDateLimit =
        Timestamp.fromDate(DateTime.now().add(const Duration(hours: 4)));
    print(now.toDate());
    print(startDateLimit.toDate());

    final eventsRef = FirebaseFirestore.instance.collection("events");
    eventsRef.where('startDate', isLessThan: startDateLimit);
    eventsRef.where('endDate', isLessThan: now);

    return Column(children: [
      BaseAppBar("Liste"),
      SizedBox(height: 20),
      Expanded(
          child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  // stream: eventsRef.snapshots(),
                  stream: _firestoreService.getEventForUser(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();
                    return Column(
                        children: snapshot.data!.docs.map((event) {
                      return
                          // FutureBuilder(
                          //   future:
                          //       _firestoreStorage.getImageURL(event['imageName']),
                          //   builder: (BuildContext context,
                          //       AsyncSnapshot<String> snapshot) {
                          //     if (snapshot.connectionState ==
                          //             ConnectionState.done &&
                          //         snapshot.hasData) {
                          //       print(snapshot.data!);
                          //       return
                          EventList(event);
                      // ;}
                      //     if (snapshot.hasData ||
                      //         snapshot.connectionState ==
                      //             ConnectionState.waiting) {
                      //       return CircularProgressIndicator();
                      //     }
                      //     return Container();
                      //   },
                      // )
                    }).toList());
                  })))
          // Column(
          //     children: event.map((event) {
          //   return EventList(event);
          // }).toList())
          )
    ]);
  }
}

class EventList extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> event;
  EventList(this.event);
  final Storage _firestoreStorage = Storage();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
              color: ThemeColors.grayColor,
              borderRadius: BorderRadius.all((Radius.circular(10)))),
          child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // BaseImage(ImageType.smallSquare, event['picture']),

                FutureBuilder(
                  future: _firestoreStorage.getImageURL(event['imageName']),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return BaseImage(ImageType.smallSquare, snapshot.data!);
                    }
                    if (snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Container();
                  },
                ),

                SizedBox(width: 8),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            flex: 5,
                            child: BaseText(
                                TextType.littleBoldText, event['name'],
                                textMaxSize: 55)),
                        Flexible(
                            flex: 1,
                            child: BaseText(TextType.littleBoldText, '2km')),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: event['tags'].map<Widget>((tag) {
                          if (event['tags'].indexOf(tag) > 3)
                            return Container();
                          return TagsWidget(TagsType.small, tag['name'],
                              Color(tag['colorValue']));
                        }).toList()),
                  ],
                )),
              ]),
        ));
  }
}
