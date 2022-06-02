import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:maelstrom/config.dart';

class TagModel {
  final String name;
  final Color color;

  TagModel(
    String this.name,
    Color this.color,
  );

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "color": color,
    };
  }
}

