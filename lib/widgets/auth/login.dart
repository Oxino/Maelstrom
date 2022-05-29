import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/pages/forgot_password.dart';
import 'package:maelstrom/widgets/base_button.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:maelstrom/widgets/form_input.dart';
// import 'package:maelstrom/widgets/utils.dart';

import '../../main.dart';
import '../base_text.dart';

// class HomePage extends BasePage {
class LoginWidget extends StatefulWidget {
  final authenticationService;
  final VoidCallback onClickedBusiness;
  final VoidCallback onClickedSignUp;
  final bool isBusiness;

  const LoginWidget(
    this.authenticationService, {
    Key? key,
    required this.onClickedBusiness,
    required this.onClickedSignUp,
    required this.isBusiness,
  }) : super(key: key);
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final bool isBusiness;

  // _LoginWidgetState(this.isBusiness);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isBusiness = widget.isBusiness;
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
                child: isBusiness
                    ? SvgPicture.asset(
                        'assets/icons/maelstrom_business.svg',
                      )
                    : SvgPicture.asset(
                        'assets/icons/maelstrom.svg',
                      ),
              ),
              SizedBox(height: 30),
              isBusiness
                  ? BaseText(TextType.sectionTitle, "MAELSTRÖM BUSINESS")
                  : BaseText(TextType.megaTitle, "MAELSTRÖM"),
              SizedBox(height: 60),
              FormInputText(
                  emailController,
                  'Votre email',
                  (email) => email != null && !EmailValidator.validate(email)
                      ? 'Entrer un email valide'
                      : null),
              SizedBox(height: 20),
              FormInputText(
                  passwordController,
                  'Votre mot de passe',
                  (value) => value != null && value.length < 5
                      ? 'Le mot de passe doit faire au moins 5 characters'
                      : null,
                  true),
              SizedBox(height: 20),
              isBusiness
                  ? BaseButton(ButtonsType.big, signIn, "Connexion", [
                      ThemeColors.principaleBusinessColor,
                      ThemeColors.radientBusinessColor
                    ])
                  : BaseButton(ButtonsType.big, signIn, "Connexion"),
              SizedBox(height: 20),
              GestureDetector(
                child: BaseText(TextType.littleText, 'Mot de passe oublié ?',
                    textColor: isBusiness
                        ? ThemeColors.principaleBusinessColor
                        : ThemeColors.principaleColor),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage())),
              ),
              SizedBox(height: 5),
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.whiteColor),
                      text: 'Pas de compte ?  ',
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isBusiness
                                ? ThemeColors.principaleBusinessColor
                                : ThemeColors.principaleColor),
                        text: "Créer en un")
                  ])),
              SizedBox(height: 15),
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.whiteColor),
                      text: isBusiness
                          ? "Vous voules savoir ou sortir avec vos amis ?"
                          : "Vous êtes directeur d'un établissement ?")),
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.whiteColor),
                      text: "Découvrez :  ",
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedBusiness,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isBusiness
                                ? ThemeColors.principaleColor
                                : ThemeColors.principaleBusinessColor),
                        text: isBusiness ? "Maelström" : "Maelström Business")
                  ])),
            ],
          ),
        ));
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    widget.authenticationService.signIn(widget.isBusiness,
        emailController.text.trim(), passwordController.text.trim());

    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //   );
    // } on FirebaseException catch (e) {
    //   print(e);

    // Utils.showSnackBar(e.message);
    // }

    // Navigatio.of(context) not working !
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
