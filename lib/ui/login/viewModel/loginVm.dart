import 'dart:async';

import 'package:yeni_okul/repository/userRepository.dart';

import '../../../service/result.dart';

enum UiState { loding, success, error }

sealed class LoginUiState<T> {
  const LoginUiState();
}

class LoginOk<T> extends LoginUiState<String> {
  final T data;

  LoginOk(this.data);
}

class Loading extends LoginUiState {}

class LoginError extends LoginUiState<String> {
  final String errorMessage;

  LoginError(this.errorMessage);
}

class LoginVm {
  String token = "";
  UiState uiState = UiState.loding;
  StreamController<LoginUiState> loadingController = StreamController();

//
  Stream<LoginUiState> get loginUiState => loadingController.stream;

  Future<UiState> loginServ(String email, String password) async {
    loadingController.sink.add(Loading());

    try {
      final apiResult =
          await UserRepository().loginService(email, password, token);

      if (apiResult is Success) {
        // Set UI state to success
        uiState = UiState.success;
        loadingController.sink.add(LoginOk(apiResult.data));
      } else if (apiResult is ResultError) {
        // Set UI state to error
        uiState = UiState.error;
      }
    } catch (e) {
      // Set UI state to error if an exception occurs
      uiState = UiState.error;
      loadingController.sink.add(LoginError("Bir Hata Oluştu"));
    }

    // Return the current UI state
    return uiState;
  }
}
