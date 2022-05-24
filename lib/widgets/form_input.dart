import 'package:flutter/material.dart';
import 'package:maelstrom/config.dart';

class FormInput extends StatelessWidget {
  final bool textHide;
  final TextEditingController inputController;
  final String inputText;
  final dynamic inputValidator;

  FormInput(this.inputController, this.inputText, this.inputValidator,
      [this.textHide = false]);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Expanded(
          child: Container(
        decoration: BoxDecoration(
            color: ThemeColors.grayColor,
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          controller: inputController,
          textInputAction: TextInputAction.done,
          obscureText: textHide,
          style: TextStyle(color: ThemeColors.whiteColor),
          decoration: InputDecoration(
            // labelText: "Votre email",
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            hintText: inputText,
            hintStyle: TextStyle(
              color: ThemeColors.textUnfocusColor,
            ),
            border: InputBorder.none,
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: inputValidator,
        ),
      )),
    );
  }
}
