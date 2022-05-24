import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/config.dart';
import 'dart:async';

import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/pageState.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    //user needs to be created before!
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future checkEmailVerified() async {
    //call after email verification
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
      
    } 
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
      // Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? PageState()
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
