import 'package:flutter/material.dart';
import 'package:yeni_okul/repository/userRepository.dart';

enum UiState { loading, success, error }

class LoginNotifier extends ChangeNotifier {
  String? _message;

  String? get message => _message;

  final String token = "";

  UiState _uiState = UiState.loading;

  UiState get uiState => _uiState;

  Future<void> postLogin(String email, String password, String token) async {
    try {
      final response = await UserRepository().loginService(email, password, token);

      _uiState = UiState.success;
      notifyListeners();
    } catch (error) {
      _uiState = UiState.error;
      _message = error.toString();
      notifyListeners();
    }
  }
}
