import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';

import '../../bloc/application_bloc.dart';
import '../../bloc/bloc_provider.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          height: 38, // Your Height
          width: 38,
          child: SvgPicture.asset(
            'assets/icons/maelstrom.svg',
          ),
        ),
        IconButton(
            icon: SizedBox(
                height: 30, // Your Height
                width: 24,
                child: SvgPicture.asset(
                  'assets/icons/user.svg',
                )),
            onPressed: () => pageBloc.setChangePage(PageType.user)),
      ]),
      backgroundColor: ThemeColors.backgroundColor,
    );
  }
}
