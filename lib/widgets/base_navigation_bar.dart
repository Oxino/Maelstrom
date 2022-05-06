import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/base_linear_gradient_mask.dart';

class BaseNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    int pageIndex = 0;
    return StreamBuilder<PageType>(
        stream: pageBloc.streamPage,
        builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: BottomNavigationBar(
                currentIndex: pageIndex,
                onTap: (value) {
                  pageBloc.setChangePage(_pageIndexToEnum(value));
                  pageIndex = value;
                  print(value);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: ItemNavigationBar('Home', 'assets/icons/home.svg'),
                    activeIcon: ItemNavigationBarActive(
                        'Home', 'assets/icons/home.svg'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: ItemNavigationBar('Liste', 'assets/icons/list.svg'),
                    activeIcon: ItemNavigationBarActive(
                        'Liste', 'assets/icons/list.svg'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: ItemNavigationBar('Map', 'assets/icons/map.svg'),
                    activeIcon:
                        ItemNavigationBarActive('Map', 'assets/icons/map.svg'),
                    label: '',
                  ),
                ],
                selectedFontSize: 0,
                elevation: 0.0,
                backgroundColor: ThemeColors.fondColor,
              ));
        });
  }

  _pageIndexToEnum(int type) {
    switch (type) {
      case 0:
        {
          return PageType.home;
        }

      case 1:
        {
          return PageType.list;
        }

      case 2:
        {
          return PageType.map;
        }

      default:
        {
          return PageType.home;
        }
    }
  }
}

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
  ItemNavigationBarActive(this.itemText, String this.itemIcon);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 91,
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
              baseLinearGradientMask(SizedBox(
                height: 20,
                child: SvgPicture.asset(itemIcon),
              )),
              SizedBox(width: 10),
              baseLinearGradientMask(BaseText(TextType.bodyText, this.itemText))
            ]));
  }
}
