import 'package:flutter/material.dart';
import 'package:maelstrom/config.dart';

class FormInputText extends StatelessWidget {
  final bool textHide;
  final TextEditingController inputController;
  final String inputText;
  final dynamic inputValidator;
  final TextInputType? keyboardType;
  final TextInputAction? keyboardButton;

  FormInputText(this.inputController, this.inputText, this.inputValidator,
      {this.textHide = false,
      TextInputType? this.keyboardType = TextInputType.text,
      this.keyboardButton = TextInputAction.next});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ThemeColors.whiteColor,
      controller: inputController,
      keyboardType: keyboardType,
      textInputAction: keyboardButton,
      obscureText: textHide,
      maxLines: keyboardType == TextInputType.multiline ? 4 : 1,
      style: TextStyle(color: ThemeColors.whiteColor, fontSize: 14.toDouble()),
      decoration: InputDecoration(
          isDense: true,
          fillColor: ThemeColors.grayColor,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintText: inputText,
          hintStyle: TextStyle(
            color: ThemeColors.textUnfocusColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          errorStyle: TextStyle(color: ThemeColors.errorColor)),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: inputValidator,
    );
  }
}
