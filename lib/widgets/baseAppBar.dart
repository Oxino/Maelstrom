import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(80);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      leading: Padding(
        // padding: EdgeInsets.only(right: 30, top: 30, left: 30, bottom: 15),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40, // Your Height
              width: 40,
              child: SvgPicture.asset(
                'assets/icons/maelstrom.svg',
                // color: Colors.red,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                color: ThemeColors.whiteColor,
                size: 30,
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
      backgroundColor: ThemeColors.fondColor,
    );
  }
}
