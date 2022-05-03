import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../config.dart';

class MainButton extends StatelessWidget {
  final ButtonsSize buttonType;
  MainButton(ButtonsSize this.buttonType);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.only(
            topLeft: Radius.circular(12), bottomRight: Radius.circular(7)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF236BFE), Color(0xFF074AD1)]),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: buttonType == ButtonsSize.icon
                ? SvgPicture.asset(
                    'assets/icons/button-icon.svg',
                    // color: Colors.red,
                  )
                : Text(
                    'Y aller !',
                    style:
                        TextStyle(fontSize: _buildButtonFontSize(buttonType)),
                  ),
          ),
          onPressed: () {}),
    );
  }

  _buildButtonFontSize(ButtonsSize type) {
    switch (type) {
      case ButtonsSize.small:
        {
          return 12.toDouble();
        }

      case ButtonsSize.big:
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
