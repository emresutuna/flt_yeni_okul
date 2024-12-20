import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../util/HexColor.dart';
import '../util/YOColors.dart';
import 'YOText.dart';
Widget dropdownButton({
  required List<String> items,
  required String hintText,
  required void Function(String? value)? onChanged,
  required void Function(String? value)? onSaved,
  String? Function(String? value)? validator,
  String? selectedValue,
  String emptyMessage = "",
  required void Function(bool value) onError,
}) {
  if (items.isEmpty) {
    onError(true);
  } else {
    onError(false);
  }
  return DropdownButtonFormField2<String>(
    isExpanded: true,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: color1.withAlpha(50), width: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      // Add more decoration..
    ),
    hint: Text(
      hintText,
      style: styleBlack12Bold,
    ),
    items: items
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: styleBlack12Bold),
            ))
        .toList(),
    validator: (value) {
      if (value == null) {
        return emptyMessage;
      }
      return null;
    },
    onChanged: (value) {
      //Do something when selected item is changed.
    },
    onSaved: (value) {
      selectedValue = value.toString() as String?;
    },
    buttonStyleData: const ButtonStyleData(
      padding: EdgeInsets.only(right: 8),
    ),
    iconStyleData: const IconStyleData(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Color(0xFF222831),
      ),
      iconSize: 24,
    ),
    dropdownStyleData: DropdownStyleData(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    menuItemStyleData: const MenuItemStyleData(
      padding: EdgeInsets.symmetric(horizontal: 16),
    ),
  );
}
