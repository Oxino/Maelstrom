import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';

class ParamItemList extends StatelessWidget {
  final String titre;
  final String? description;
  final bool isActive;
  ParamItemList(this.titre, this.description, this.isActive);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: isActive
                ? BoxDecoration(
                    color: ThemeColors.grayColor,
                    borderRadius: BorderRadius.all((Radius.circular(10))),
                    border: Border.all(
                        color: ThemeColors.principaleColor, width: 2))
                : BoxDecoration(
                    color: ThemeColors.grayColor,
                    borderRadius: BorderRadius.all((Radius.circular(10)))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BaseText(TextType.bodyBoldText, titre),
                if (description != null) SizedBox(height: 5),
                if (description != null)
                  BaseText(TextType.littleText, description!),
              ],
            )));
  }
}
