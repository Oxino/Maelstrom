// import '';

import 'package:flutter/material.dart';
import 'package:maelstrom/pages/maelstrom/home.dart';
import 'package:maelstrom/pages/maelstrom/list.dart';
import 'package:maelstrom/pages/maelstrom/map.dart';
import 'package:maelstrom/pages/maelstrom_business/create_event.dart';
import 'package:maelstrom/pages/maelstrom_business/dashboard.dart';
import 'package:maelstrom/pages/maelstrom_business/business_events.dart';
import 'package:maelstrom/pages/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';

import 'package:maelstrom/widgets/base_navigation_bar.dart';
import 'package:maelstrom/widgets/business_event_app_bar.dart';
import 'package:maelstrom/widgets/business_navigation_bar.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class UserApp extends StatelessWidget {
  final isBusiness;
  UserApp(bool this.isBusiness);

  @override
  Widget build(BuildContext context) {
    print(isBusiness);
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    return StreamBuilder<PageType>(
        stream: pageBloc.streamPage,
        initialData: isBusiness ? PageType.dashboard : PageType.home,
        builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
          var currentPageItems = _getPageType(snapshot.requireData);
          return Scaffold(
            backgroundColor: ThemeColors.backgroundColor,
            appBar: currentPageItems[0],
            // buildBar(),
            body: currentPageItems[1],
            bottomNavigationBar: currentPageItems[2],
          );
        });
  }

  _getPageType(PageType type) {
    if (isBusiness) {
      switch (type) {
        case PageType.dashboard:
          {
            return [HomeAppBar(), Dashboard(), BusinessNavigationBar()];
          }
        case PageType.businessEvent:
          {
            return [
              BusinessEventAppBar(),
              EventPage(),
              BusinessNavigationBar()
            ];
          }
        case PageType.createEvent:
          {
            return [
              BaseAppBar("Créer un évènement"),
              CreateEventPage(),
              BusinessNavigationBar()
            ];
          }
        case PageType.user:
          {
            return [
              BaseAppBar(FirebaseAuth.instance.currentUser!.email!),
              UserPage(),
              BusinessNavigationBar()
            ];
          }
        case PageType.user:
          {
            return [
              BaseAppBar(FirebaseAuth.instance.currentUser!.email!),
              UserPage(),
              BusinessNavigationBar()
            ];
          }
        default:
          {
            return [HomeAppBar(), Dashboard(), BusinessNavigationBar()];
          }
      }
    } else {
      switch (type) {
        case PageType.home:
          {
            return [HomeAppBar(), HomePage(), BaseNavigationBar()];
          }
        case PageType.list:
          {
            return [BaseAppBar("Map"), ListPage(), BaseNavigationBar()];
          }
        case PageType.map:
          {
            return [BaseAppBar("Map"), MapPage(), BaseNavigationBar()];
          }
        case PageType.user:
          {
            return [
              BaseAppBar(FirebaseAuth.instance.currentUser!.email!),
              UserPage(),
              BaseNavigationBar()
            ];
          }
        default:
          {
            return [HomeAppBar(), HomePage(), BaseNavigationBar()];
          }
      }
    }
  }
}
