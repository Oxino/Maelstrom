import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business.dart';
import 'package:maelstrom/widgets/auth/sign_up_business_first_step.dart';
import 'package:maelstrom/widgets/auth/sign_up_business_second_step.dart';

import 'package:maelstrom/widgets/base_text.dart';

import 'package:google_fonts/google_fonts.dart';

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
  Business infoBusiness = Business();

  void toggle() => setState(() => isFirstStep = !isFirstStep);

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
                Row(
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
                ),
                SizedBox(
                  height: 50,
                ),
                isFirstStep
                    ? SignUpBusinessFirstStep(onClickedStep: toggle, infoBusiness: infoBusiness)
                    : SignUpBusinessSecondStep(widget.authenticationService,
                        onClickedStep: toggle, infoBusiness: infoBusiness),
                SizedBox(
                  height: 20,
                ),
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
                    ]))
              ]),
        ));
  }
}
