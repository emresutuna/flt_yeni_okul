import 'package:flutter/material.dart';

class YellowCard extends StatelessWidget {
  final double? radius;
  final Widget child;


  const YellowCard({super.key, this.radius = 16, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}