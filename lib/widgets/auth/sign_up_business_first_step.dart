import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business.dart';

import 'package:maelstrom/widgets/base_button.dart';
import 'package:maelstrom/widgets/base_text.dart';

import 'package:maelstrom/widgets/form_input.dart';

class SignUpBusinessFirstStep extends StatefulWidget {
  final VoidCallback onClickedStep;
  Business infoBusiness;

  SignUpBusinessFirstStep({
    Key? key,
    required this.onClickedStep,
    required this.infoBusiness,
  }) : super(key: key);
  @override
  _SignUpBusinessFirstStepState createState() =>
      _SignUpBusinessFirstStepState();
}

class _SignUpBusinessFirstStepState extends State<SignUpBusinessFirstStep> {
  final institutionNameController = TextEditingController();
  final siretController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    institutionNameController.dispose();
    siretController.dispose();
    addressController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BaseText(TextType.bigText, "Les informations sur votre établissement :"),
      SizedBox(height: 20),
      FormInput(
          institutionNameController,
          "Le nom de votre établissement",
          (name) => name != null && name.length < 2
              ? "Le nom de l'établissement doit faire au moins 2 characters"
              : null),
      SizedBox(height: 20),
      FormInput(
          siretController,
          "Numéro SIRET",
          (value) => value != null && value.length < 2
              ? "Le nom de l'établissement doit faire au moins 6 characters"
              : null),
      SizedBox(height: 20),
      FormInput(
          addressController,
          "L'adresse de l'établissement",
          (address) => address != null && address.length < 2
              ? "L'adresse de l'établissementT doit faire au moins 8 characters"
              : null),
      SizedBox(height: 20),
      FormInput(
          descriptionController,
          "Description de votre établissement",
          (description) => description != null && description.length < 2
              ? "Le numéro SIRET doit faire au moins 2 characters"
              : null),
      SizedBox(height: 20),
      BaseButton(ButtonsType.big, widget.onClickedStep, "Suivant", [
        ThemeColors.principaleBusinessColor,
        ThemeColors.radientBusinessColor
      ]),
    ]);
  }

  goToSecondStep() {
    widget.infoBusiness.institutionName = institutionNameController.text.trim();
    widget.infoBusiness.siret = siretController.text.trim();
    widget.infoBusiness.address = addressController.text.trim();
    widget.infoBusiness.description = descriptionController.text.trim();
    print(widget.infoBusiness.siret);
    print(widget.infoBusiness.address);
    print(widget.infoBusiness.description);
    
    widget.onClickedStep;
  }
}
