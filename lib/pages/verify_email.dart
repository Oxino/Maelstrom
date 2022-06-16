import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:maelstrom/bloc/firestore_bloc.dart';
import 'package:maelstrom/config.dart';
import 'dart:async';

import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/page_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:maelstrom/bloc/firestoreService.dart';

class VerifyEmailPage extends StatefulWidget {
  final authenticationService;
  VerifyEmailPage(this.authenticationService);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();

  static FirestoreService() {}
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  // final FirestoreService _firestoreService = FirestoreService();
  bool isEmailVerified = false;
  Timer? timer;
  bool isBusinessUser = false;

  @override
  void initState() {
    super.initState();

    isBusinessUser = widget.authenticationService.isBusinessUser;

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (widget.authenticationService.isInitEmailVerification()) {
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future checkEmailVerified() async {
    //call after email verification
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = widget.authenticationService.checkEmailVerified();
      // isEmailVerified = true;
    });

    if (isEmailVerified) {
      isBusinessUser = widget.authenticationService.isBusinessUser;
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  
  // final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').doc(currentId).snapshots();

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? 
      
      PageStream(isBusinessUser)
      : Scaffold(
          backgroundColor: ThemeColors.backgroundColor,
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150, // Your Height
                      width: 150,
                      child: SvgPicture.asset(
                        'assets/icons/maelstrom.svg',
                      ),
                    ),
                    SizedBox(height: 50),
                    BaseText(TextType.sectionTitle, "Verifiez votre email"),
                    SizedBox(height: 30),
                    BaseText(TextType.bodyText,
                        "Bienvenu parmis nous ! Il vous reste juste une dernière étape. Nous vous avons envoyé un mail de verification merci de cliquer sur le lien contenu dans le mail afin d'accéder a votre compte"),
                  ])));
}