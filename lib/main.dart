// import '';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/pages/home.dart';
import 'package:maelstrom/pages/list.dart';
import 'package:maelstrom/pages/map.dart';

// import 'package:maelstrom/pages/main_screen.dart';

void main() {
  runApp(
      BlocProvider<ApplicationBloc>(bloc: ApplicationBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicationBloc pageBloc = BlocProvider.of<ApplicationBloc>(context);
    return MaterialApp(
      theme: ThemeData(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        primaryColor: Color(0xFF236BFE),
        backgroundColor: Color(0xFF181929),

        fontFamily: GoogleFonts.poppins(
          color: ThemeColors.whiteColor,
          fontSize: 14,
        ).fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mealstrom',
      home: StreamBuilder<PageType>(
          stream: pageBloc.streamPage,
          initialData: PageType.home,
          builder: (BuildContext context, AsyncSnapshot<PageType> snapshot) {
            return _buildPages(snapshot.requireData);
          }),
    );
  }

  _buildPages(PageType type) {
    switch (type) {
      case PageType.home:
        {
          return HomePage();
        }

      case PageType.map:
        {
          return MapPage();
        }

      case PageType.list:
        {
          return ListPage();
        }

      default:
        {
          return HomePage();
        }
    }
  }
}
