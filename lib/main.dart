// import '';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

import 'package:maelstrom/pages/home.dart';
import 'package:maelstrom/pages/list.dart';
import 'package:maelstrom/pages/login.dart';
import 'package:maelstrom/pages/map.dart';
import 'package:maelstrom/widgets/base_app_bar.dart';

import 'package:maelstrom/widgets/base_navigation_bar.dart';
import 'package:maelstrom/widgets/home/home_app_bar.dart';

// import 'package:maelstrom/pages/main_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                backgroundColor: ThemeColors.backgroundColor,
                appBar: HomeAppBar(),
                // buildBar(),
                body: StreamBuilder<PageType>(
                    stream: pageBloc.streamPage,
                    initialData: PageType.login,
                    builder: (BuildContext context,
                        AsyncSnapshot<PageType> snapshot) {
                      return _buildPages(snapshot.requireData)[1];
                    }),
                bottomNavigationBar: BaseNavigationBar(),
              );
            } else {
              return Scaffold(
                  backgroundColor: ThemeColors.backgroundColor,
                  body: LoginPage());
            }
          }),
    );
  }
}

_buildPages(PageType type) {
  switch (type) {
    case PageType.home:
      {
        return [HomeAppBar(), HomePage()];
      }
    case PageType.login:
      {
        return [BaseAppBar("Login"), LoginPage()];
      }

    case PageType.map:
      {
        return [BaseAppBar("Map"), MapPage()];
      }

    case PageType.list:
      {
        return [BaseAppBar("Map"), ListPage()];
      }

    default:
      {
        return [HomeAppBar(), HomePage()];
      }
  }
}
