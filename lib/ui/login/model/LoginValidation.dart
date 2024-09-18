import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeni_okul/util/YOColors.dart';

class LoginValidation extends GetxController {
  // TextEditingController'ları Rx yapmayın
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Reaktif boolean değişkenler
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;

  bool loginValid() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || !email.isEmail) {
      isEmailValid.value = false;
    } else {
      isEmailValid.value = true;
    }

    if (password.isEmpty || password.length < 8) {
      isPasswordValid.value = false;
    } else {
      isPasswordValid.value = true;
    }

    if (!isEmailValid.value || !isPasswordValid.value) {
      Get.snackbar(
        "Hata", "Kullanıcı adı veya şifre yanlış",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }
    return true;
  }
}