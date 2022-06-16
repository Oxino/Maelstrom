import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/config.dart';

import '../bloc/application_bloc.dart';
import '../bloc/bloc_provider.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  final String? leftIcon;
  final PageType? leftIconFuction;
  final String? textBar;
  final String? rightIcon;
  final PageType? rightIconFuction;
  BaseAppBar(
      {String? this.leftIcon,
      PageType? this.leftIconFuction,
      String? this.textBar,
      String? this.rightIcon,
      PageType? this.rightIconFuction});
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    return AppBar(
      titleSpacing: 0,
      elevation: 0.0,
      // leading: null,
      // automaticallyImplyLeading: true,
      title: Row(
          mainAxisAlignment: rightIcon != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leftIcon != null && leftIconFuction != null)
              Container(
                  padding: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                      onTap: () => pageBloc.setChangePage(leftIconFuction!),
                      child: SizedBox(
                        width: 20, // Your Height
                        child: SvgPicture.asset(
                          leftIcon!,
                        ),
                      ))),
            if (textBar != null) BaseText(TextType.pageTitle, textBar!),
            if (rightIcon != null && rightIconFuction != null)
              GestureDetector(
                  onTap: () => pageBloc.setChangePage(rightIconFuction!),
                  child: SizedBox(
                    width: 20, // Your Height
                    child: SvgPicture.asset(
                      rightIcon!,
                    ),
                  )),
          ]),
      backgroundColor: ThemeColors.backgroundColor,
    );
  }
}

// class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
//   Size get preferredSize => new Size.fromHeight(60);
//   final String textBar;
//   final backFunction;
//   final Color backgroundBar;
//   BaseAppBar(String this.textBar, this.backFunction,
//       [Color this.backgroundBar = ThemeColors.backgroundColor]);
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       titleSpacing: 0,
//       elevation: 0.0,
//       // leading: null,
//       // automaticallyImplyLeading: true,
//       title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//                 // When the child is tapped, show a snackbar.
//                 onTap: backFunction,
//                 child: SizedBox(
//                   width: 11,
//                   height: 18, // Your Height
//                   child: SvgPicture.asset(
//                     'assets/icons/arrow-back.svg',
//                   ),
//                 )),
//             SizedBox(width: 15),
//             BaseText(TextType.pageTitle, textBar)
//           ]),
//       backgroundColor: backgroundBar,
//     );
//   }
// }
