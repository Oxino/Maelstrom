import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

// import 'package:maelstrom/widgets/base_text.dart';
// import 'package:maelstrom/widgets/home/search_section.dart';
// import 'package:maelstrom/widgets/home/promote_section.dart';
// import 'package:maelstrom/widgets/home/reco_section.dart';

// class HomePage extends BasePage {
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              child: Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: ThemeColors.grayColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(color: ThemeColors.whiteColor),
                  decoration: InputDecoration(
                    // labelText: "Votre email",
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Votre email',
                    hintStyle: TextStyle(
                      color: ThemeColors.textUnfocusColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              child: Expanded(
                  child: Container(
                decoration: BoxDecoration(
                    color: ThemeColors.grayColor,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  style: TextStyle(color: ThemeColors.whiteColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    hintText: 'Votre mot de passe',
                    hintStyle: TextStyle(
                      color: ThemeColors.textUnfocusColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: signIn, child: Text('Connexion'))
          ],
        ),
      ));

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
