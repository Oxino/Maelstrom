// import '';

import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/tags.dart';
import 'package:maelstrom/widgets/base_image.dart';

class ListPage extends StatelessWidget {
  final List eventList = [
    {
      'title':
          'Soirée célib : Faites des rencontre bla blab labfnzzkljj oimf zehsoa lfn ejijk bavamk aoieflefk njf ',
      'place': 'La casacasa casacasa casa casacasacasac ',
      'picture': 'assets/images/image1.jpg',
      'km': '1km',
      'tag': [],
    },
    {
      'title': 'Tournois Super Smash Bros Ulitimate',
      'place': 'Le R4dom',
      'picture': 'assets/images/image2.jpg',
      'km': '1.5km',
      'tag': [],
    },
    {
      'title': 'Soirée aèvec DJ Snake  1 conso offerte',
      'place': 'La plage',
      'picture': 'assets/images/image3.jpg',
      'km': '2km',
      'tag': [],
    },
    {
      'title': 'Soirée Beer Pong',
      'place': 'La Grange',
      'picture': 'assets/images/image2.jpg',
      'km': '2km',
      'tag': [],
    },
    {
      'title': 'Rencontre Geek',
      'place': 'Le Sherlock',
      'picture': 'assets/images/image1.jpg',
      'km': '2.5km',
      'tag': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
            child: Column(
                children: eventList.map((event) {
          return EventList(event);
        }).toList())));
  }
}

class EventList extends StatelessWidget {
  final Map eventList;
  EventList(this.eventList);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
              color: ThemeColors.grayColor,
              borderRadius: BorderRadius.all((Radius.circular(10)))),
          child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BaseImage(ImageType.smallSquare, eventList['picture']),
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
                                TextType.littleBoldText, eventList['title'],
                                textMaxSize: 55)),
                        Flexible(
                            flex: 1,
                            child: BaseText(
                                TextType.littleBoldText, eventList['km'])),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Tags(TagsType.medium, "Guest", TagsColors.greenTag),
                        SizedBox(width: 5),
                        Tags(TagsType.medium, "Jeux vidéo",
                            TagsColors.purpleTag),
                        SizedBox(width: 5),
                        Tags(TagsType.medium, "Promo", TagsColors.blueTag),
                      ],
                    ),
                  ],
                )),
              ]),
        ));
  }
}
