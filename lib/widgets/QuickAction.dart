import 'package:flutter/material.dart';

import 'YOText.dart';

class QuickAction extends StatelessWidget {
  final String icon;
  final String name;

  const QuickAction({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 16),
              alignment: Alignment.center,
              height: 60,
              width: 60,
              // Border width
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(icon,fit: BoxFit.contain,),

                  ],
                ),
              )),
          Container(
            width: 80,
            padding: const EdgeInsets.only(top: 4),
            child: Center(
              child: YoText(
                text: name,
                size: 10,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
