import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';
import 'package:maelstrom/pages/maelstrom/map_page.dart';
import 'package:maelstrom/pages/maelstrom/path_page.dart';
import 'package:maelstrom/pages/maelstrom_business/business_event_page.dart';

import 'package:maelstrom/pages/user.dart';
import 'package:maelstrom/pages/maelstrom/home_page.dart';
import 'package:maelstrom/pages/maelstrom/list_page.dart';
import 'package:maelstrom/pages/maelstrom/event_page.dart';
import 'package:maelstrom/pages/maelstrom_business/dashboard.dart';
import 'package:maelstrom/pages/maelstrom_business/business_list_event.dart';
import 'package:maelstrom/pages/maelstrom_business/create_event.dart';

import 'package:maelstrom/widgets/base_navigation_bar.dart';
import 'package:maelstrom/widgets/business_navigation_bar.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class PageStream extends StatelessWidget {
  final isBusiness;
  PageStream(bool this.isBusiness);

  @override
  Widget build(BuildContext context) {
    // final currentId = FirebaseAuth.instance.currentUser!.uid;
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
                    snapshot.requireData == PageType.event ||
                    snapshot.requireData == PageType.path ||
                    snapshot.requireData == PageType.businessSingleEvent
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
            return BusinessListEventPage();
          }
        case PageType.createEvent:
          {
            return CreateEventPage();
          }
        case PageType.user:
          {
            return UserPage(isBusiness);
          }
        case PageType.businessSingleEvent:
          {
            return BusinessEventPage();
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
            return UserPage(isBusiness);
          }
        case PageType.event:
          {
            return EventPage();
          }
        case PageType.path:
          {
            return PathPage();
          }
        default:
          {
            return HomePage();
          }
      }
    }
  }
}
