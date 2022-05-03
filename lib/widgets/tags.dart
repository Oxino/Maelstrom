import 'package:flutter/material.dart';
import '../config.dart';

class Tags extends StatelessWidget {
  final TagsSize tagType;
  final String tagText;
  final Color tagColor;
  Tags(TagsSize this.tagType, String this.tagText, Color this.tagColor);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: tagType == TagsSize.bubble
          ? EdgeInsets.all(5)
          : EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: tagType == TagsSize.bubble
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

  _buildFontSize(TagsSize type) {
    switch (type) {
      case TagsSize.small:
        {
          return 8.toDouble();
        }

      case TagsSize.medium:
        {
          return 12.toDouble();
        }

      case TagsSize.big:
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
