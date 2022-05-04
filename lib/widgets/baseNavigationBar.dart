import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'baseText.dart';
import '../config.dart';

class BaseNavigationBar extends StatelessWidget {
  final pageController;
  final selectedPage;
  BaseNavigationBar(this.pageController, this.selectedPage);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: BottomNavigationBar(
          currentIndex: selectedPage,
          onTap: (value) => pageController.animateToPage(value,
              duration: Duration(microseconds: 300), curve: Curves.easeIn),

          items: [
            BottomNavigationBarItem(
              icon: ItemNavigationBar(
                  pageController == 0, 'Home', 'assets/icons/home.svg'),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ItemNavigationBar(
                  pageController == 1, 'Liste', 'assets/icons/list.svg'),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ItemNavigationBar(
                  pageController == 2, 'Map', 'assets/icons/map.svg'),
              label: '',
            ),
          ],
          // selectedFontSize: 0,
          // selectedItemColor: ThemeColors.principaleColor,
          // unselectedItemColor: ThemeColors.whiteColor,
          backgroundColor: ThemeColors.fondColor,
        ));
  }
}

class ItemNavigationBar extends StatelessWidget {
  final bool isActive;
  final String itemText;
  final String itemIcon;
  ItemNavigationBar(bool this.isActive, this.itemText, String this.itemIcon);
  @override
  Widget build(BuildContext context) {
    return isActive
        ? Container(
            width: 91,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(7)),
              color: ThemeColors.grayColor,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LinearGradientMask(SizedBox(
                    height: 20,
                    child: SvgPicture.asset(itemIcon),
                  )),
                  SizedBox(width: 10),
                  LinearGradientMask(BaseText(TextType.bodyText, this.itemText))
                ]))
        : Container(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              height: 20,
              child: SvgPicture.asset(itemIcon),
            ));
  }
}

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) {
          return RadialGradient(
            center: Alignment.topCenter,
            radius: 1,
            colors: [ThemeColors.principaleColor, ThemeColors.radientColor],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        child: child);
  }
}
