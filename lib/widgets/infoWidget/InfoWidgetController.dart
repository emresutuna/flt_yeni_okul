
import 'package:flutter/material.dart';

class InfoCardController extends ChangeNotifier {
  final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(true);

  void toggle() {
    isExpanded.value = !isExpanded.value;
    notifyListeners();
  }

  @override
  void dispose() {
    isExpanded.dispose();
    super.dispose();
  }
}