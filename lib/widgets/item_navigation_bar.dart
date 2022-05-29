import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/base_linear_gradient_mask.dart';

class ItemNavigationBar extends StatelessWidget {
  final String itemText;
  final String itemIcon;
  ItemNavigationBar(this.itemText, String this.itemIcon);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          height: 20,
          child: SvgPicture.asset(itemIcon),
        ));
  }
}

class ItemNavigationBarActive extends StatelessWidget {
  final String itemText;
  final String itemIcon;
  final bool isBusiness;
  ItemNavigationBarActive(this.itemText, String this.itemIcon,
      [bool this.isBusiness = false]);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: isBusiness ? 130 : 91,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), bottomRight: Radius.circular(7)),
          color: ThemeColors.grayColor,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              baseLinearGradientMask(
                  SizedBox(
                    height: 20,
                    child: SvgPicture.asset(itemIcon),
                  ),
                  isBusiness ? true : false),
              SizedBox(width: 10),
              BaseText(TextType.bodyText, this.itemText,
                  textColor: isBusiness
                      ? ThemeColors.principaleBusinessColor
                      : ThemeColors.principaleColor),
            ]));
  }
}
