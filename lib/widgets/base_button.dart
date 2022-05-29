import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:maelstrom/config.dart';

class BaseButton extends StatelessWidget {
  final ButtonsType buttonType;
  final String buttonText;
  final buttonFunction;
  final List<Color> buttonColor;
  BaseButton(ButtonsType this.buttonType, void Function()? this.buttonFunction,
      [String this.buttonText = "Y aller !",
      List<Color> this.buttonColor = const [
        ThemeColors.principaleColor,
        ThemeColors.radientColor
      ]]);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(12), bottomRight: Radius.circular(7)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [buttonColor[0], buttonColor[1]]),
      ),
      child: TextButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Padding(
            padding: buttonType == ButtonsType.big
                ? EdgeInsets.symmetric(vertical: 10, horizontal: 30)
                : EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: buttonType == ButtonsType.icon
                ? SvgPicture.asset(
                    'assets/icons/button-icon.svg',
                    // color: Colors.red,
                  )
                : Text(
                    buttonText,
                    style: TextStyle(
                        fontSize: _buildButtonFontSize(buttonType),
                        color: ThemeColors.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
          ),
          onPressed: buttonFunction),
    );
  }

  _buildButtonFontSize(ButtonsType type) {
    switch (type) {
      case ButtonsType.small:
        {
          return 12.toDouble();
        }

      case ButtonsType.big:
        {
          return 15.toDouble();
        }

      default:
        {
          return 12.toDouble();
        }
    }
  }
}
