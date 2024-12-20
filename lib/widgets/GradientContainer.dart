import 'package:flutter/material.dart';

import '../util/HexColor.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;

  const GradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(radius: 8, colors: [
          HexColor("#ecfbf9"),
          HexColor("#daf8f3"),
          HexColor("#c8f5ed"),
          HexColor("#b6f2e7"),
          HexColor("#79F0BD"),
        ])),
        child: child);
  }
}
