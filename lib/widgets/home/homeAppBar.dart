import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../pages/user.dart';

import '../../config.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                }),
          ])),
      backgroundColor: ThemeColors.backgroundColor,
    );
  }
}
