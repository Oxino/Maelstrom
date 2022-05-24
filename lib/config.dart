import 'package:flutter/material.dart';

enum TagsType { bubble, small, medium, big }
enum ButtonsType { icon, small, big }
enum TextType {
  megaTitle,
  pageTitle,
  sectionTitle,
  bigText,
  bodyBoldText,
  bodyText,
  littleBoldText,
  littleText,
  smallText
}
enum ImageType { big, promote, reco, square, smallSquare }
enum PageType { home, list, map, user, login }

class ThemeColors {
  static const principaleColor = Color(0xFF236BFE);
  static const backgroundColor = Color(0xFF181929);
  static const fondColor = Color(0xFF181929);
  static const whiteColor = Color(0xFFf1f1f1);
  static const textUnfocusColor = Color.fromARGB(77, 241, 241, 241);
  static const grayColor = Color(0xFF272b3e);
  static const radientColor = Color(0xFF074AD1);
}

class TagsColors {
  static const yellowTag = Color(0xFFFFC952);
  static const blueTag = Color(0xFF39B3FA);
  static const redTag = Color(0xFFFA552D);
  static const greenTag = Color(0xFF79E674);
  static const purpleTag = Color(0xFFB665E6);
}
