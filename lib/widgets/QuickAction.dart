import 'package:flutter/material.dart';
import '../util/YOColors.dart';

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
              width: 80,
              height: 80,
              // Border width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                  width: 2.0,
                  color: color5,
                ),
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icon,
                      fit: BoxFit.contain,
                      color: color5,
                    ),

                  ],
                ),
              )),
          Text(
            name,
            style: styleBlack12Bold,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
