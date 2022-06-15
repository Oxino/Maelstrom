import 'package:flutter/material.dart';
import 'package:maelstrom/models/tag_model.dart';

enum TagsType { bubble, small, medium, big, button }

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
  smallText,
}

enum ImageType { big, promote, reco, square, smallSquare }

enum PageType {
  home,
  list,
  map,
  user,
  login,
  dashboard,
  createEvent,
  businessEvent,
  event
}

class AllTags {
  static getAllTagsSort() {
    List<dynamic> allTags = [
      {'name': 'Jeux-vidéo', 'colorValue': 0xFFB665E6},
      {'name': 'Film', 'colorValue': 0xFFFFC952},
      {'name': 'Musique', 'colorValue': 0xFFFA552D},
      {'name': 'Guest', 'colorValue': 0xFF79E674},
      {'name': 'Célibataire', 'colorValue': 0xFF39B3FA},
      {'name': 'Déguisement', 'colorValue': 0xFFB665E6},
      {'name': 'Jeux de société', 'colorValue': 0xFFFFC952},
      {'name': 'Blind test', 'colorValue': 0xFFFA552D},
      {'name': 'Promo', 'colorValue': 0xFF79E674},
      {'name': 'Quizz', 'colorValue': 0xFF39B3FA},
      {'name': 'Autre', 'colorValue': 0xFFB665E6},
      {'name': 'Karaoké', 'colorValue': 0xFFFFC952},
      {'name': 'Jeux', 'colorValue': 0xFFFA552D},
      {'name': 'Barathon', 'colorValue': 0xFF79E674},
      {'name': 'Détente', 'colorValue': 0xFF39B3FA},
    ];
    allTags.sort((a, b) => a["name"].compareTo(b["name"]));
    return allTags;
  }
}

class ThemeColors {
  static const principaleColor = Color(0xFFBB82EC);
  static const principaleBusinessColor = Color(0xFF236BFE);
  static const radientColor = Color(0xFF7F20D1);
  static const radientBusinessColor = Color(0xFF074AD1);
  static const backgroundColor = Color(0xFF181929);
  static const fondColor = Color(0xFF181929);
  static const whiteColor = Color(0xFFf1f1f1);
  static const textUnfocusColor = Color.fromARGB(77, 241, 241, 241);
  static const grayColor = Color(0xFF272b3e);
  static const errorColor = Color(0xFFFA552D);
}

class TagsColors {
  static const yellowTag = Color(0xFFFFC952);
  static const blueTag = Color(0xFF39B3FA);
  static const redTag = Color(0xFFFA552D);
  static const greenTag = Color(0xFF79E674);
  static const purpleTag = Color(0xFFB665E6);
}
