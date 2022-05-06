import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:maelstrom/config.dart';

class BaseText extends StatelessWidget {
  final TextType textType;
  final Color textColor;
  final String textContent;
  dynamic textMaxSize;
  BaseText(TextType this.textType, String this.textContent,
      {Color this.textColor = ThemeColors.whiteColor,
      dynamic textMaxSize = 0}) {
    this.textMaxSize = textMaxSize;
  }
  @override
  Widget build(BuildContext context) {
    return Text(
        textMaxSize == 0
            ? textContent
            : textContent.length > textMaxSize
                ? textContent.substring(0, textMaxSize) + '...'
                : textContent,
        style: textType == TextType.megaTitle ||
                textType == TextType.pageTitle ||
                textType == TextType.sectionTitle
            ? TextStyle(
                fontFamily: 'Dosis',
                fontSize: _buildFontSize(textType),
                fontWeight: _buildFontWeight(textType),
                color: textColor,
              )
            : GoogleFonts.poppins(
                fontSize: _buildFontSize(textType),
                fontWeight: _buildFontWeight(textType),
                color: textColor));
  }

  _buildFontWeight(TextType type) {
    if (type == TextType.bigText ||
        type == TextType.bodyBoldText ||
        type == TextType.littleBoldText) {
      return FontWeight.w600;
    } else {
      return FontWeight.w400;
    }
  }

  _buildFontSize(TextType type) {
    switch (type) {
      case TextType.megaTitle:
        {
          return 50.toDouble();
        }

      case TextType.pageTitle:
        {
          return 28.toDouble();
        }
      case TextType.sectionTitle:
        {
          return 24.toDouble();
        }
      case TextType.bigText:
        {
          return 18.toDouble();
        }
      case TextType.bodyBoldText:
      case TextType.bodyText:
        {
          return 14.toDouble();
        }
      case TextType.littleBoldText:
      case TextType.littleText:
        {
          return 12.toDouble();
        }
      case TextType.smallText:
        {
          return 8.toDouble();
        }

      default:
        {
          return 14.toDouble();
        }
    }
  }
}
