import 'package:flutter/material.dart';

class CompanyListNotifier extends ChangeNotifier {
  bool isSearching = false;
  bool isPageLoading = true;

  void setLoading(bool value) {
    isPageLoading = value;
    notifyListeners();
  }

  void setSearching(bool value) {
    isSearching = value;
    notifyListeners();
  }
}
