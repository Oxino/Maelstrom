// import '';

import 'package:flutter/material.dart';
import 'package:maelstrom/pages/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/pages/home.dart';
import 'package:maelstrom/pages/list.dart';
import 'package:maelstrom/pages/map.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';

import 'package:maelstrom/widgets/base_navigation_bar.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class PageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);

    return StreamBuilder<PageType>(
        stream: pageBloc.streamPage,
        initialData: PageType.home,
        builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
          var currentPageItems = _getPageType(snapshot.requireData);
          return Scaffold(
            backgroundColor: ThemeColors.backgroundColor,
            appBar: currentPageItems[0],
            // buildBar(),
            body: currentPageItems[1],
            bottomNavigationBar: BaseNavigationBar(),
          );
        });
  }

  _getPageType(PageType type) {
    switch (type) {
      case PageType.home:
        {
          return [HomeAppBar(), HomePage()];
        }
      case PageType.list:
        {
          return [BaseAppBar("Map"), ListPage()];
        }
      case PageType.map:
        {
          return [BaseAppBar("Map"), MapPage()];
        }
      case PageType.user:
        {
          return [
            BaseAppBar(FirebaseAuth.instance.currentUser!.email!),
            UserPage()
          ];
        }
      default:
        {
          return [HomeAppBar(), HomePage()];
        }
    }
  }
}
