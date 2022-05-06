import 'package:flutter/material.dart';

import 'package:maelstrom/config.dart';

class baseLinearGradientMask extends StatelessWidget {
  baseLinearGradientMask(this.child);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) {
          return RadialGradient(
            center: Alignment.topCenter,
            radius: 1,
            colors: [ThemeColors.principaleColor, ThemeColors.radientColor],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        child: child);
  }
}
