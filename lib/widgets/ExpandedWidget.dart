import 'package:flutter/material.dart';

import 'YOCardView.dart';

class ExpandedWidget extends StatelessWidget {
  final Widget title;
  final Widget children;

  const ExpandedWidget(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return YOCardView(
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: title,
          children: <Widget>[children],
        ),
      ),
    );
  }
}
