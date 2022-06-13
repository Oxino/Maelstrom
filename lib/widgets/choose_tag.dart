import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class ChooseTag extends StatefulWidget {
  var setTagsController;
  var selectedTags;
  // allTags.sort((a, b) => a["name"].compareTo(b["name"]));
  ChooseTag(this.setTagsController, this.selectedTags, {Key? key})
      : super(key: key);

  @override
  State<ChooseTag> createState() => _ChooseTagState();
}

class _ChooseTagState extends State<ChooseTag> {
  bool isExpend = false;
  final allTags = AllTags.getAllTagsSort();
  @override
  Widget build(BuildContext context) {
    List visibleTags = isExpend ? allTags : widget.selectedTags;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText(TextType.sectionTitle, 'Tags'),
          IconButton(
              icon: SizedBox(
                  height: 24, // Your Height
                  width: 24,
                  child: SvgPicture.asset(
                    'assets/icons/plus.svg',
                  )),
              onPressed: () => setState(() => isExpend = !isExpend))
        ],
      ),
      SizedBox(height: 5),
      Wrap(
          spacing: 7,
          runSpacing: 10,
          children: visibleTags.map<Widget>((tag) {
            return InkWell(
                onTap: () => widget.setTagsController(tag),
                child: TagsWidget(
                    TagsType.button,
                    tag['name'],
                    widget.selectedTags.contains(tag)
                        ? Color(tag['colorValue'])
                        : ThemeColors.grayColor));
          }).toList())
    ]);
  }
}
