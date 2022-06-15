import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/pages/user.dart';
import 'package:maelstrom/pages/maelstrom/home_page.dart';
import 'package:maelstrom/pages/maelstrom/list_page.dart';
import 'package:maelstrom/pages/maelstrom/map_page.dart';
import 'package:maelstrom/pages/maelstrom/business_page.dart';
import 'package:maelstrom/pages/maelstrom_business/dashboard.dart';
import 'package:maelstrom/pages/maelstrom_business/business_events.dart';
import 'package:maelstrom/pages/maelstrom_business/create_event.dart';

import 'package:maelstrom/widgets/base_navigation_bar.dart';
import 'package:maelstrom/widgets/business_navigation_bar.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class PageStream extends StatelessWidget {
  final isBusiness;
  PageStream(bool this.isBusiness);

  @override
  Widget build(BuildContext context) {
    final currentId = FirebaseAuth.instance.currentUser!.uid;
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: null,
      body: StreamBuilder<PageType>(
          stream: pageBloc.streamPage,
          initialData: isBusiness ? PageType.dashboard : PageType.home,
          builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
            var currentPageItems = _getPageType(snapshot.requireData);
            return snapshot.requireData == PageType.map ||
                    snapshot.requireData == PageType.event
                ? currentPageItems
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: currentPageItems);
          }),
      bottomNavigationBar:
          isBusiness ? BusinessNavigationBar() : BaseNavigationBar(),
    );
  }

  _getPageType(PageType type) {
    if (isBusiness) {
      switch (type) {
        case PageType.dashboard:
          {
            return Dashboard();
          }
        case PageType.businessEvent:
          {
            return BusinessEventPage();
          }
        case PageType.createEvent:
          {
            return CreateEventPage();
          }
        case PageType.user:
          {
            return UserPage();
          }
        default:
          {
            return Dashboard();
          }
      }
    } else {
      switch (type) {
        case PageType.home:
          {
            return HomePage();
          }
        case PageType.list:
          {
            return ListPage();
          }
        case PageType.map:
          {
            return MapPage();
          }
        case PageType.user:
          {
            return UserPage();
          }
        case PageType.event:
          {
            return EventPage();
          }
        default:
          {
            return HomePage();
          }
      }
    }
  }
}
