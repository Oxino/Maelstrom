import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      leading: IconButton(
        icon: SizedBox(
          width: 11,
          height: 18, // Your Height
          child: SvgPicture.asset(
            'assets/icons/arrow-back.svg',
          ),
        ),
        onPressed: () => pageBloc.setChangePage(PageType.home),
      ),
      automaticallyImplyLeading: false,
      title: BaseText(TextType.pageTitle, textBar),
      backgroundColor: backgroundBar,
    );
  }
}
