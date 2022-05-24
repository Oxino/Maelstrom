import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/models/curent_user.dart';

import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:maelstrom/widgets/form_input.dart';

import '../../main.dart';

// class HomePage extends BasePage {
class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: formKey,
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
              SizedBox(height: 30),
              BaseText(TextType.sectionTitle, "Créer mon compte"),
              SizedBox(height: 20),
              FormInput(
                  usernameController,
                  "Votre nom d'utilisateur",
                  (usernae) => usernae != null && usernae.length < 6
                      ? "Le nom d'utilisateur doit faire au moins 6 characters"
                      : null),
              SizedBox(height: 20),
              FormInput(
                  emailController,
                  'Votre email',
                  (email) => email != null && !EmailValidator.validate(email)
                      ? 'Entrer un email valide'
                      : null),
              SizedBox(height: 20),
              FormInput(
                  passwordController,
                  'Votre mot de passe',
                  (value) => value != null && value.length < 6
                      ? 'Le mot de passe doit faire au moins 6 characters'
                      : null,
                  true),
              SizedBox(height: 20),
              BaseButton(ButtonsType.big, signUp, "Crée mon compte"),
              SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.whiteColor),
                      text: 'Vouz avez un compte ?  ',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.principaleColor),
                        text: "Connextez vous !")
                  ]))
            ],
          ),
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    createUser(usernameController, emailController);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        print('Le mot de passe est trop faible');
      } else if (e.code == 'email-already-in-use') {
        print('un compte existe déjà pour cet email');
      }
      // Utils.showSnackBar(e.message);
    }

    // Navigatio.of(context) not working !
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future createUser(userName, email) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = CurentUser(id: docUser.id, userName: userName, email: email);
    final json = user.toJson();

    await docUser.set(json);
  }
}
