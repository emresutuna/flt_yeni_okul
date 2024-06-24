import 'package:flutter/material.dart';

import 'YOText.dart';

class CompanyListItem extends StatelessWidget {
  final String icon;
  final String name;
  final bool isFavorite;

  const CompanyListItem(
      {super.key,
      required this.icon,
      required this.name,
      required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: const Icon(Icons.favorite_outline),
          ),
          Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.0,
                  color: Colors.black,
                ),
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  icon,
                  fit: BoxFit.fill,
                ),
              )),
          Container(
            padding: const EdgeInsets.only(top: 4),
            child: Center(
              child: YoText(
                text: name,
                size: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
