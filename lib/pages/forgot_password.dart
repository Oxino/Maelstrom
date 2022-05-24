import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ThemeColors.backgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0.0,
          leading: IconButton(
            icon: SizedBox(
              width: 11,
              height: 18, // Your Height
              child: SvgPicture.asset(
                'assets/icons/arrow-back.svg',
              ),
            ),
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          automaticallyImplyLeading: false,
          title: BaseText(TextType.pageTitle, 'Mot de passe oublié'),
          backgroundColor: ThemeColors.backgroundColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseText(TextType.bodyText,
                  "Entrez votre adresse mail afin que nous puissions vous envoyer un mail pour réinitialiser votre mot de passe"),
              SizedBox(height: 20),
              Container(
                  height: 40,
                  child: Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: ThemeColors.grayColor,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.done,
                            style: TextStyle(color: ThemeColors.whiteColor),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                              hintText: 'Votre email',
                              hintStyle: TextStyle(
                                color: ThemeColors.textUnfocusColor,
                              ),
                              border: InputBorder.none,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Entrer un email valide'
                                    : null,
                          )))),
              SizedBox(height: 20),
              BaseButton(ButtonsType.big, resetPassword,
                  "Reinitialiser mon mot de passe"),
            ],
          ),
        ),
      );

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // Utils.showSnackBar('Email de réinitialisation envoyé !');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      // Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
