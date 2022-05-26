// import '';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:maelstrom/pages/auth.dart';
import 'package:maelstrom/pages/verify_email.dart';
import 'package:maelstrom/services/authentication_service.dart';
// import 'package:maelstrom/widgets/utils.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/bloc/bloc_provider.dart';
import 'package:maelstrom/bloc/application_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      BlocProvider<ApplicationBloc>(bloc: ApplicationBloc(), child: MyApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();
final AuthenticationService authenticationService = AuthenticationService();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
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
            return snapshot.hasData
                ? VerifyEmailPage(authenticationService)
                : Scaffold(
                    backgroundColor: ThemeColors.backgroundColor,
                    appBar: AppBar(
                      titleSpacing: 0,
                      elevation: 0.0,
                      backgroundColor: ThemeColors.backgroundColor,
                    ),
                    body: AuthPage(authenticationService));
          }),
    );
  }
}
