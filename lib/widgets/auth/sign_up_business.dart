import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/main.dart';
import 'package:maelstrom/widgets/base_button.dart';
// import 'package:maelstrom/widgets/auth/sign_up_business_first_step.dart';
// import 'package:maelstrom/widgets/auth/sign_up_business_second_step.dart';

import 'package:maelstrom/widgets/base_text.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:maelstrom/widgets/form_input.dart';

// class HomePage extends BasePage {
class SignUpBusinessWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  final authenticationService;

  const SignUpBusinessWidget(
    this.authenticationService, {
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);
  @override
  _SignUpBusinessWidgetState createState() => _SignUpBusinessWidgetState();
}

class _SignUpBusinessWidgetState extends State<SignUpBusinessWidget> {
  final formKey = GlobalKey<FormState>();
  bool isFirstStep = true;
  int currentStep = 0;
  final institutionNameController = TextEditingController();
  final siretController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    institutionNameController.dispose();
    siretController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void toggle() => setState(() => isFirstStep = !isFirstStep);

  // void setBusinessBossInfo () {};

  @override
  Widget build(BuildContext context) {
    final isLastStep = currentStep == getSteps().length - 1;
    return Form(
      key: formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50, // Your Height
                      width: 50,
                      child: SvgPicture.asset(
                        'assets/icons/maelstrom_business.svg',
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: BaseText(TextType.sectionTitle,
                            "Créer mon compte établissement")),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Expanded( child:
            Theme(
                data: ThemeData(
                  fontFamily: GoogleFonts.poppins(
                    color: ThemeColors.whiteColor,
                    fontSize: 14,
                  ).fontFamily,
                  canvasColor: ThemeColors.backgroundColor,
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: ThemeColors.principaleBusinessColor,
                      background: ThemeColors.grayColor,
                      secondary: ThemeColors.grayColor),
                ),
                child: 
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: 
                    Stepper(
                      margin: EdgeInsets.all(0),
                      elevation: 0.0,
                      type: StepperType.horizontal,
                      steps: getSteps(),
                      currentStep: currentStep,
                      onStepContinue: () {
                        if (isLastStep) {
                          print('Envoyer les datas');
                          signUp();
                        } else {
                          setState(() => currentStep += 1);
                        }
                      },
                      onStepCancel: () {
                        currentStep == 0
                            ? null
                            : setState(() => currentStep -= 1);
                      },
                      controlsBuilder: (context, ControlsDetails details) {
                        return Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (currentStep != 0)
                                  BaseButton(ButtonsType.big,
                                      details.onStepCancel, "Précédent", [
                                    ThemeColors.grayColor,
                                    ThemeColors.grayColor
                                  ]),
                                if (currentStep != 0)
                                  SizedBox(
                                    height: 20,
                                  ),
                                BaseButton(
                                    ButtonsType.big,
                                    details.onStepContinue,
                                    isLastStep ? "Crée mon compte" : "Suivant",
                                    [
                                      ThemeColors.principaleBusinessColor,
                                      ThemeColors.radientBusinessColor
                                    ]),
                              ],
                            ));
                      },
                    ))
                )
                ),
            if (currentStep == 0)
            SizedBox(
              height: 20,
            ),
            if (currentStep == 0)
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
                            color: ThemeColors.principaleBusinessColor),
                        text: "Connectez-vous !")
                  ])),
            SizedBox(
              height: 50,
            ),
          ]),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          title: SizedBox(),
          isActive: currentStep >= 0,
          content: Column(children: [
            BaseText(
                TextType.bigText, "Les informations sur votre établissement :"),
            SizedBox(height: 20),
            FormInputText(
                institutionNameController,
                "Le nom de votre établissement",
                (name) => name != null && name.length < 2
                    ? "Le nom de l'établissement doit faire au moins 2 characters"
                    : null),
            SizedBox(height: 20),
            FormInputText(
                siretController,
                "Numéro SIRET",
                (value) => value != null && value.length < 2
                    ? "Le nom de l'établissement doit faire au moins 6 characters"
                    : null),
            SizedBox(height: 20),
            FormInputText(
                addressController,
                "L'adresse de l'établissement",
                (address) => address != null && address.length < 2
                    ? "L'adresse de l'établissementT doit faire au moins 8 characters"
                    : null,
                    keyboardType: TextInputType.streetAddress),
            SizedBox(height: 20),
            FormInputText(
                descriptionController,
                "Description de votre établissement",
                (description) => description != null && description.length < 2
                    ? "Le numéro SIRET doit faire au moins 2 characters"
                    : null,
                    keyboardButton: TextInputAction.done,),
          ]),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          title: SizedBox(),
          isActive: currentStep >= 1,
          content: Column(children: [
            BaseText(TextType.bigText, "Les informations sur vous :"),
            SizedBox(height: 20),
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
            FormInputText(
                emailController,
                'Votre email',
                (email) => email != null && !EmailValidator.validate(email)
                    ? 'Entrer un email valide'
                    : null,
                    keyboardType: TextInputType.emailAddress,),
            SizedBox(height: 20),
            FormInputText(
                passwordController,
                'Votre mot de passe',
                (value) => value != null && value.length < 6
                    ? 'Le mot de passe doit faire au moins 6 characters'
                    : null,
                textHide: true,
                keyboardButton: TextInputAction.done),
          ]),
        )
      ];

  Future signUp() async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    widget.authenticationService.signUpBusinessWithEmail(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      institutionName: institutionNameController.text.trim(),
      siret: siretController.text.trim(),
      address: addressController.text.trim(),
      description: descriptionController.text.trim(),
    );

    // Navigatio.of(context) not working !
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
