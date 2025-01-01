import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordUpdateValidation extends GetxController {
  TextEditingController oldPwdController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  TextEditingController rePwdController = TextEditingController();

  RxString oldPasswordError = ''.obs;
  RxString newPasswordError = ''.obs;
  RxString rePasswordError = ''.obs;

  bool updatePasswordValid() {
    String oldPassword = oldPwdController.text.trim();
    String password = newPwdController.text.trim();
    String rePassword = rePwdController.text.trim();

    oldPasswordError.value = '';
    newPasswordError.value = '';
    rePasswordError.value = '';

    bool isValid =
        true;

    if (oldPassword.isEmpty) {
      oldPasswordError.value = 'Eski şifre boş olamaz.';
      isValid = false;
    } else if (oldPassword.length < 8) {
      oldPasswordError.value = 'Eski şifre en az 8 karakter olmalıdır.';
      isValid = false;
    }

    if (password.isEmpty) {
      newPasswordError.value = 'Yeni şifre boş olamaz.';
      isValid = false;
    } else if (password.length < 8) {
      newPasswordError.value = 'Yeni şifre en az 8 karakter olmalıdır.';
      isValid = false;
    }

    if (rePassword.isEmpty) {
      rePasswordError.value = 'Yeni şifre tekrar boş olamaz.';
      isValid = false;
    } else if (rePassword != password) {
      rePasswordError.value = 'Şifreler aynı değil.';
      isValid = false;
    }

    if (!isValid) {
      if (oldPasswordError.value.isNotEmpty) {
        Get.snackbar("Hata", oldPasswordError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      if (newPasswordError.value.isNotEmpty) {
        Get.snackbar("Hata", newPasswordError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      if (rePasswordError.value.isNotEmpty) {
        Get.snackbar("Hata", rePasswordError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      return false;
    }

    return true;
  }
}
