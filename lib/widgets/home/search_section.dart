import 'package:flutter/material.dart';
// import 'package:flutter/semantics.dart';
import 'package:maelstrom/config.dart';

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext contexfontt) {
    return Container(
      height: 40,
      child: Expanded(
          child: Container(
        decoration: BoxDecoration(
            color: ThemeColors.grayColor,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          style: TextStyle(color: ThemeColors.whiteColor),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            hintText: 'Rechercher',
            hintStyle: TextStyle(
              color: ThemeColors.whiteColor,
            ),
            border: InputBorder.none,
          ),
        ),
      )),
    );
  }
}
