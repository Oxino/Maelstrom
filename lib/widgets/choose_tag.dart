import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/tags_widget.dart';

class ChooseTag extends StatefulWidget {
  var setTagsController;
  var removeTagController;
  var selectedTags;
  ChooseTag(this.setTagsController, this.removeTagController, this.selectedTags,
      {Key? key})
      : super(key: key);

  @override
  State<ChooseTag> createState() => _ChooseTagState();
}

class _ChooseTagState extends State<ChooseTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
          spacing: 7,
          runSpacing: 10,
          children: allTags.map<Widget>((tag) {
            print(widget.selectedTags);
            var isSelected = (widget.selectedTags.singleWhere(
                (it) => it['name'] == tag['name'],
                orElse: () => null));
            print(isSelected);
            return TextButton(
                onPressed: widget.setTagsController(tag),
                child: TagsWidget(
                    TagsType.button,
                    tag['name'],
                    isSelected == null
                        ? ThemeColors.grayColor
                        : Color(tag['colorValue'])));
          }).toList()),
    );
  }
}
