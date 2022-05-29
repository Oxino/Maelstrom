import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

class baseLinearGradientMask extends StatelessWidget {
  baseLinearGradientMask(this.child, [bool this.isBusiness = false]);
  final Widget child;
  final bool isBusiness;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isBusiness
                ? [
                    ThemeColors.principaleBusinessColor,
                    ThemeColors.radientBusinessColor
                  ]
                : [ThemeColors.principaleColor, ThemeColors.radientColor],
          ).createShader(bounds);
        },
        child: child);
  }
}
