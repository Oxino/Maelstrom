import 'package:flutter/material.dart';
import 'package:maelstrom/widgets/baseButton.dart';
import 'package:maelstrom/widgets/baseText.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import '../../config.dart';
import '../tags.dart';

class RecoSection extends StatelessWidget {
  final List recoList = [
    {
      'title': 'Soirée célib : Faites des rencontres !',
      'place': 'La casa',
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
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          mainAxisExtent: 210,
        ),
        shrinkWrap: true,
        children: recoList.map((reco) {
          return RecoCard(reco);
        }).toList());
  }
}

class RecoCard extends StatelessWidget {
  final Map recoData;
  RecoCard(this.recoData);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: ThemeColors.grayColor,
          borderRadius: BorderRadius.all((Radius.circular(10)))),
      // child: Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 92,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  image: DecorationImage(
                    image: AssetImage(
                      recoData['picture'],
                    ),
                    fit: BoxFit.cover,
                  )),
              child: Stack(
                children: [
                  Positioned(
                    top: 75,
                    right: 0,
                    child: Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 3, 1),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(6)),
                          color: ThemeColors.grayColor,
                        ),
                        child:
                            BaseText(TextType.littleBoldText, recoData['km'])),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            BaseText(TextType.littleBoldText, recoData['title']),
            SizedBox(height: 8),
            BaseText(TextType.littleText, recoData['place']),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Tags(TagsType.bubble, "test", TagsColors.yellowTag),
                    SizedBox(width: 5),
                    Tags(TagsType.bubble, "test", TagsColors.blueTag),
                    SizedBox(width: 5),
                    Tags(TagsType.bubble, "test", TagsColors.redTag),
                  ],
                ),
                BaseButton(ButtonsType.icon),
              ],
            )
          ]),
    );
  }
}
