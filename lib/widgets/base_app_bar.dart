import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/main.dart';

import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/config.dart';

import '../bloc/application_bloc.dart';
import '../bloc/bloc_provider.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  final String textBar;
  final Color backgroundBar;
  BaseAppBar(String this.textBar,
      [Color this.backgroundBar = ThemeColors.backgroundColor]);
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    return AppBar(
      titleSpacing: 0,
      elevation: 0.0,
      // leading: null,
      // automaticallyImplyLeading: true,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                // When the child is tapped, show a snackbar.
                onTap: () => pageBloc.setChangePage(PageType.home),
                child: SizedBox(
                  width: 11,
                  height: 18, // Your Height
                  child: SvgPicture.asset(
                    'assets/icons/arrow-back.svg',
                  ),
                )),
            SizedBox(width: 15),
            BaseText(TextType.pageTitle, textBar)
          ]),
      backgroundColor: backgroundBar,
    );
  }
}
