import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/HexColor.dart';
import '../util/YOColors.dart';

class YoSearchBar extends StatefulWidget {
  final void Function(String query) onQueryChanged;
  final VoidCallback? onClear;
  final VoidCallback? onClearCallback; // Yeni callback
  final FocusNode? focusNode; // Dışarıdan FocusNode alacak

  const YoSearchBar({
    super.key,
    required this.onQueryChanged,
    this.onClear,
    this.onClearCallback,
    this.focusNode, // FocusNode parametresi eklendi
  });

  @override
  State<YoSearchBar> createState() => _YoSearchBarState();
}

class _YoSearchBarState extends State<YoSearchBar> {
  String query = '';
  final TextEditingController _controller = TextEditingController();

  void _handleQueryChange(String newQuery) {
    setState(() {
      query = newQuery;
    });
    widget.onQueryChanged(newQuery);
  }

  void _clearQuery() {
    setState(() {
      query = '';
      _controller.clear();
    });

    // FocusNode üzerinden focus kaldır
    widget.focusNode?.unfocus();

    // onClear callback tetikle
    if (widget.onClear != null) {
      widget.onClear!();
    }

    // Ek clear callback tetikle
    if (widget.onClearCallback != null) {
      widget.onClearCallback!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 9,
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 8),
      alignment: Alignment.centerLeft,
      child: Center(
        child: TextField(
          controller: _controller,
          focusNode: widget.focusNode, // Dışarıdan gelen FocusNode kullanılıyor
          onChanged: _handleQueryChange,
          style: styleBlack12Bold,
          decoration: InputDecoration(
            suffixIcon: query.length >= 3
                ? IconButton(
              icon: const Icon(Icons.clear),
              color: HexColor("#80333333"),
              onPressed: _clearQuery,
            )
                : const Icon(Icons.search, color: Colors.black54),
            contentPadding: const EdgeInsets.all(8.0),
            fillColor: Colors.white,
            filled: true,
            hintText: 'Arama...',
            hintStyle: GoogleFonts.montserrat(
              color: HexColor("#80333333"),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor("#80333333"), width: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor("#80333333"), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

