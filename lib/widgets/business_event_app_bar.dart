import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_text.dart';

import '../bloc/application_bloc.dart';
import '../bloc/bloc_provider.dart';

class BusinessEventAppBar extends StatelessWidget
    implements PreferredSizeWidget {
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
        BaseText(TextType.pageTitle, 'Vos évènements'),
        IconButton(
            icon: SizedBox(
                height: 24, // Your Height
                width: 24,
                child: SvgPicture.asset(
                  'assets/icons/plus.svg',
                )),
            onPressed: () => pageBloc.setChangePage(PageType.createEvent)),
      ]),
      backgroundColor: ThemeColors.backgroundColor,
    );
  }
}
