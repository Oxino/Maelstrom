import 'package:flutter/material.dart';

import '../../config.dart';

import '../../widgets/tags.dart';
import '../../widgets/mainButton.dart';

class PromoteSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Evènement de la soirée',
                style: TextStyle(
                  fontFamily: 'Dosis',
                  color: ThemeColors.whiteColor,
                  fontSize: 24,
                ),
              ),
            )),
        Container(
          padding: EdgeInsets.only(right: 8, top: 8, left: 8, bottom: 15),
          decoration: BoxDecoration(
              color: ThemeColors.grayColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 77,
                  width: 125,
                  margin: EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/image3.jpg',
                        ),
                        fit: BoxFit.cover,
                      )),
                  child: null,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Soirée célib! Faites des rencontres!',
                      style: TextStyle(
                          color: ThemeColors.whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'La casa',
                      style: TextStyle(
                        color: ThemeColors.whiteColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ))
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Tags(TagsSize.small, "Célibataire", Color(0xFFffc952)),
                    SizedBox(width: 5),
                    Tags(TagsSize.small, "Célibataire", Color(0xFFffc952)),
                    SizedBox(width: 5),
                    Tags(TagsSize.small, "Célibataire", Color(0xFFffc952)),
                  ],
                ),
                MainButton(ButtonsSize.small),
              ],
            ),
          ]),
        ),
      ],
    ));
  }
}
