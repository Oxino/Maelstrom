// import '';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/bloc/storage.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/tag_model.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/choose_tag.dart';
import 'package:maelstrom/widgets/tags_widget.dart';
import 'package:maelstrom/widgets/base_image.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final FirestoreService _firestoreService = FirestoreService();

  List activeTags = [];

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

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      BaseAppBar("Liste"),
      SizedBox(height: 20),
      ChooseTag(setActiveTags, activeTags),
      SizedBox(height: 30),
      BaseText(TextType.sectionTitle, 'Les Evènements'),
      SizedBox(height: 15),
      Expanded(
          child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firestoreService.getEventForUser(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();
                    return Column(
                        children: snapshot.data!.docs.map((event) {
                      return EventList(event);
                    }).toList());
                  }))))
    ]);
  }

  void setActiveTags(Map value) => setState(() {
        activeTags.contains(value)
            ? activeTags.remove(value)
            : activeTags.add(value);

        activeTags.sort((a, b) => a["name"].compareTo(b["name"]));
      });
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
