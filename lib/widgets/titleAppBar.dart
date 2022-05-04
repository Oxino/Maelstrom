import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'baseText.dart';

import '../config.dart';

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  final String textBar;
  TitleAppBar(String this.textBar);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leadingWidth: 0,
      titleSpacing: 0,
      elevation: 0.0,
      leading: IconButton(
        icon: SizedBox(
          width: 11,
          height: 18, // Your Height
          child: SvgPicture.asset(
            'assets/icons/arrow-back.svg',
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      automaticallyImplyLeading: false,
      title: BaseText(TextType.pageTitle, textBar),
      backgroundColor: ThemeColors.backgroundColor,
    );
  }
}
