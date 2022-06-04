import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maelstrom/models/tag_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';

class TagPicker extends StatefulWidget {
  var setTagsController;
  var removeTagController;
  var selected_items;
  TagPicker(
      this.setTagsController, this.removeTagController, this.selected_items,
      {Key? key})
      : super(key: key);

  @override
  State<TagPicker> createState() => _TagPickerState();
}

class _TagPickerState extends State<TagPicker> {
  @override
  Widget build(BuildContext context) {
    List<String> all_items = [
      "Célibataire",
      "Autre",
      "Promo",
      "Jeux vidéo",
      "Guest",
      "Quizz",
      "Film",
      "Blind Test",
    ];
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 0.0),
              color: Colors.transparent,
              blurRadius: 0.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: ThemeColors.grayColor,
        ),
        child: MultiSelectDialogField(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          colorator: (value) {
            if (value != null) {
              return Color((value as Map)['colorValue']);
            }
            return ThemeColors.principaleBusinessColor;
          },
          title: BaseText(TextType.bigText, "Tags"),
          buttonIcon: Icon(
            Icons.local_offer,
            size: 20.toDouble(),
            color: widget.selected_items.length != 0
                ? ThemeColors.whiteColor
                : ThemeColors.textUnfocusColor,
          ),
          selectedItemsTextStyle: GoogleFonts.poppins(
              fontSize: 12.toDouble(),
              fontWeight: FontWeight.w400,
              color: ThemeColors.whiteColor),
          selectedColor: ThemeColors.principaleBusinessColor,
          itemsTextStyle: TextStyle(
            color: ThemeColors.textUnfocusColor,
            fontSize: 12.toDouble(),
            fontWeight: FontWeight.w400,
          ),
          unselectedColor: ThemeColors.grayColor,
          confirmText: Text("Valider",
              style: GoogleFonts.poppins(
                  fontSize: 14.toDouble(),
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.principaleBusinessColor)),
          cancelText: Text("Annuler",
              style: GoogleFonts.poppins(
                  fontSize: 14.toDouble(),
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.textUnfocusColor)),
          buttonText: Text("Ses tags",
              style: GoogleFonts.poppins(
                  fontSize: 14.toDouble(),
                  fontWeight: FontWeight.w400,
                  color: widget.selected_items.length > 0
                      ? ThemeColors.whiteColor
                      : ThemeColors.textUnfocusColor)),
          backgroundColor: ThemeColors.backgroundColor,
          items: allTags.map((e) => MultiSelectItem(e, e['name'])).toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            widget.setTagsController(values);
          },
          chipDisplay: MultiSelectChipDisplay(
            items: widget.selected_items,
            chipColor: ThemeColors.principaleBusinessColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: GoogleFonts.poppins(
                fontSize: 12.toDouble(),
                fontWeight: FontWeight.w400,
                color: ThemeColors.whiteColor),
            // alignment: Alignment.center,
            onTap: (value) {
              setState(() {
                widget.removeTagController(value);
              });
            },
          ),
        ));
  }
}
