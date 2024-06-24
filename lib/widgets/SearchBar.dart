import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/util/HexColor.dart';

class YoSearchBar extends StatefulWidget {
  const YoSearchBar(
      {super.key, required void Function(String query) onQueryChanged});

  @override
  State<YoSearchBar> createState() => _YoSearchBarState();
}

class _YoSearchBarState extends State<YoSearchBar> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 9,
        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 8),
        alignment: Alignment.centerLeft,
        child: Center(
          child: TextField(
            onChanged: onQueryChanged,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.search),
                suffixIconColor: HexColor("#bcbcbc"),
                contentPadding: EdgeInsets.all(8.0),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Arama...',
                hintStyle: GoogleFonts.montserrat(
                    color: HexColor("#818181"),
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#F0F1FA"), width: 2),
                  borderRadius: BorderRadius.circular(24),
                ),
                focusColor: HexColor("F0F1FA")),
          ),
        ));
  }
}
