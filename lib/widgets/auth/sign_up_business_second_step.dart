import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business.dart';

import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/form_input.dart';

import '../../main.dart';

class SignUpBusinessSecondStep extends StatefulWidget {
  final VoidCallback onClickedStep;
  final authenticationService;
  Business infoBusiness;

  SignUpBusinessSecondStep(
    this.authenticationService, {
    Key? key,
    required this.onClickedStep,
    required this.infoBusiness,
  }) : super(key: key);
  @override
  _SignUpBusinessSecondSteppState createState() =>
      _SignUpBusinessSecondSteppState();
}

class _SignUpBusinessSecondSteppState extends State<SignUpBusinessSecondStep> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BaseText(TextType.bigText, "Les informations sur vous :"),
      SizedBox(height: 20),
      FormInput(
          firstNameController,
          "Votre prénom",
          (firstName) => firstName != null && firstName.length < 2
              ? "Votre prénom doit faire au moins 2 characters"
              : null),
      SizedBox(height: 20),
      FormInput(
          lastNameController,
          "Votre nom",
          (lastName) => lastName != null && lastName.length < 2
              ? "Votre nom doit faire au moins 2 characters"
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseButton(ButtonsType.big, widget.onClickedStep, "Précédent",
              [ThemeColors.grayColor, ThemeColors.grayColor]),
          SizedBox(
            width: 30,
          ),
          BaseButton(ButtonsType.big, signUp, "Crée mon compte", [
            ThemeColors.principaleBusinessColor,
            ThemeColors.radientBusinessColor
          ]),
        ],
      )
    ]);
  }

  Future signUp() async {
    widget.infoBusiness.firstName = firstNameController.text.trim();
    widget.infoBusiness.lastName = lastNameController.text.trim();
    widget.infoBusiness.email = emailController.text.trim();

    // final isValid = formKey.currentState!.validate();

    // if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    print(widget.infoBusiness.siret);
    print(widget.infoBusiness.address);
    print(widget.infoBusiness.description);
    print(widget.infoBusiness.firstName);
    print(widget.infoBusiness.lastName);
    print(widget.infoBusiness.email);
    // widget.authenticationService.signUpWithEmail(
    //     email: emailController.text.trim(),
    //     password: passwordController.text.trim(),
    //     firstName: firstNameController.text.trim(),
    //     lastName: lastNameController.text.trim());

    // Navigatio.of(context) not working !
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
