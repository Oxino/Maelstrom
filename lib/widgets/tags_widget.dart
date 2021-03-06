import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

class TagsWidget extends StatelessWidget {
  final TagsType tagType;
  final String tagText;
  final Color tagColor;
  TagsWidget(TagsType this.tagType, String this.tagText, Color this.tagColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: tagType == TagsType.bubble
          ? EdgeInsets.all(5)
          : EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: tagType == TagsType.button
            ? BorderRadius.only(
                topLeft: Radius.circular(12), bottomRight: Radius.circular(7))
            : BorderRadius.circular(8),
      ),
      child: tagType == TagsType.bubble
          ? Container()
          : Text(
              tagText,
              style: TextStyle(
                color: ThemeColors.whiteColor,
                fontSize: _buildFontSize(tagType),
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  _buildFontSize(TagsType type) {
    switch (type) {
      case TagsType.small:
        {
          return 8.toDouble();
        }

      case TagsType.medium:
        {
          return 12.toDouble();
        }

      case TagsType.big:
        {
          return 15.toDouble();
        }
      case TagsType.button:
        {
          return 12.toDouble();
        }

      default:
        {
          return 12.toDouble();
        }
    }
  }
}
