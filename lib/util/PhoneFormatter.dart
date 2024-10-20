import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.length > 14) return oldValue; // Maximum length

    String newText = '';
    int index = 0;
    if (text.isNotEmpty) {
      newText += '(';
    }
    for (int i = 0; i < text.length && index < 14; i++) {
      if (index == 4) {
        newText += ')-';
        index += 2;
      } else if (index == 9 || index == 12) {
        newText += '-';
        index++;
      }
      newText += text[i];
      index++;
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
