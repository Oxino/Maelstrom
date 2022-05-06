import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

class Tags extends StatelessWidget {
  final TagsType tagType;
  final String tagText;
  final Color tagColor;
  Tags(TagsType this.tagType, String this.tagText, Color this.tagColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: tagType == TagsType.bubble
          ? EdgeInsets.all(5)
          : EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(8),
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

      default:
        {
          return 12.toDouble();
        }
    }
  }
}
