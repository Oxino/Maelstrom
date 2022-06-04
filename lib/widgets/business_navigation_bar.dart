import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/widgets/item_navigation_bar.dart';

class BusinessNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    int pageIndex = 0;
    return StreamBuilder<PageType>(
        stream: pageBloc.streamPage,
        builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
          return Container(
              color: ThemeColors.backgroundColor,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: BottomNavigationBar(
                    currentIndex: pageIndex,
                    onTap: (value) {
                      pageBloc.setChangePage(_pageIndexToEnum(value));
                      pageIndex = value;
                    },
                    items: [
                      BottomNavigationBarItem(
                          icon: ItemNavigationBar(
                              'Home', 'assets/icons/home.svg'),
                          activeIcon: ItemNavigationBarActive(
                              'Dashboard', 'assets/icons/home.svg', true),
                          label: ''),
                      BottomNavigationBarItem(
                        icon:
                            ItemNavigationBar('Liste', 'assets/icons/list.svg'),
                        activeIcon: ItemNavigationBarActive(
                            'Event', 'assets/icons/list.svg', true),
                        label: '',
                      ),
                    ],
                    selectedFontSize: 0,
                    elevation: 0.0,
                    backgroundColor: ThemeColors.fondColor,
                  )));
        });
  }

  _pageIndexToEnum(int type) {
    switch (type) {
      case 0:
        {
          return PageType.dashboard;
        }

      case 1:
        {
          return PageType.businessEvent;
        }

      default:
        {
          return PageType.dashboard;
        }
    }
  }
}
