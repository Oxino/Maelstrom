// import '';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maelstrom/bloc/authentication_bloc.dart';
import 'package:maelstrom/bloc/business_bloc.dart';
import 'package:maelstrom/bloc/event_bloc.dart';
import 'package:maelstrom/pages/auth.dart';
import 'package:maelstrom/pages/verify_email.dart';
import 'package:maelstrom/widgets/utils.dart';
// import 'package:maelstrom/widgets/utils.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

Future main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider<BusinessBloc>(
          bloc: BusinessBloc(),
          child: BlocProvider<EventBloc>(bloc: EventBloc(), child: MyApp()))));
}

final navigatorKey = GlobalKey<NavigatorState>();
final AuthenticationService authenticationService = AuthenticationService();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      // scaffoldMessengerKey: Utils.messengerKey,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('en'), const Locale('fr')],
      navigatorKey: navigatorKey,
      theme: ThemeData(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        primaryColor: ThemeColors.principaleBusinessColor,
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
            return snapshot.hasData
                ? VerifyEmailPage(authenticationService)
                : Scaffold(
                    backgroundColor: ThemeColors.backgroundColor,
                    body: SafeArea(child: AuthPage(authenticationService)));
          }),
    );
  }
}
