import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';

import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:maelstrom/widgets/date_time_picker.dart';
import 'package:maelstrom/widgets/form_input.dart';

import '../../main.dart';

// class HomePage extends BasePage {
class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  final authenticationService;

  const SignUpWidget(
    this.authenticationService, {
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  DateTime? dateController;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50, // Your Height
                  width: 50,
                  child: SvgPicture.asset(
                    'assets/icons/maelstrom.svg',
                  ),
                ),
                SizedBox(width: 20),
                BaseText(TextType.sectionTitle, "Créer mon compte"),
              ],
            ),
            SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // BaseText(TextType.sectionTitle, "Créer mon compte"),
                  // SizedBox(height: 20),
                  FormInputText(
                      firstNameController,
                      "Votre prénom",
                      (firstName) => firstName != null && firstName.length < 2
                          ? "Votre prénom doit faire au moins 2 characters"
                          : null),
                  SizedBox(height: 20),
                  FormInputText(
                      lastNameController,
                      "Votre nom",
                      (lastName) => lastName != null && lastName.length < 2
                          ? "Votre nom doit faire au moins 2 characters"
                          : null),
                  SizedBox(height: 20),
                  DateTimePicker(
                    true,
                    setDateController,
                    dateController,
                    "Votre date de naissance",
                    ThemeColors.principaleColor,
                    startDate: 1920,
                    endDate: 2050,
                  ),
                  SizedBox(height: 20),
                  FormInputText(
                      emailController,
                      'Votre email',
                      (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Entrer un email valide'
                              : null),
                  SizedBox(height: 20),
                  FormInputText(
                      passwordController,
                      'Votre mot de passe',
                      (value) => value != null && value.length < 6
                          ? 'Le mot de passe doit faire au moins 6 characters'
                          : null,
                      textHide: true,
                      keyboardButton: TextInputAction.done),
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
            )
          ]),
        ));
  }

  void setDateController(value) => setState(() => dateController = value);

  Future signUp() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) return;
    if (dateController == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: BaseText(
            TextType.bodyBoldText, "Veuillez rentre votre date de naissance"),
        backgroundColor: ThemeColors.errorColor,
      ));
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    var dateTimeController = dateController?.add(Duration());

    var timestampController = Timestamp.fromDate(
        dateTimeController != null ? dateTimeController : DateTime.now());

    widget.authenticationService.signUpWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        birthDate: timestampController);

    // Navigatio.of(context) not working !
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
