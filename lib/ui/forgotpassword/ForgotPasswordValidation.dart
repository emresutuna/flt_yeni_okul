import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordValidation extends GetxController {
  TextEditingController emailController = TextEditingController();

  RxBool isEmailValid = true.obs;

  bool loginValid() {
    String email = emailController.text.trim();

    if (email.isEmpty || !email.isEmail) {
      isEmailValid.value = false;
    } else {
      isEmailValid.value = true;
    }


    if (!isEmailValid.value ) {
      Get.snackbar(
        "Hata", "Yanlış mail",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }
}