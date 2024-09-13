import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/util/YOColors.dart';

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style:
                GoogleFonts.notoSans(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}