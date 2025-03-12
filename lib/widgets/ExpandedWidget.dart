import 'package:flutter/material.dart';
import '../util/YOColors.dart';

class ExpandedWidget extends StatelessWidget {
  final Widget title;
  final Widget children;

  const ExpandedWidget(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 0.5,
              color: color2,
            )),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: title,
            children: <Widget>[children],
          ),
        ),
      ),
    );
  }
}
