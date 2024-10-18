import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterValidation extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController tcknController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Reaktif boolean değişkenler
  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxBool isPhoneValid = true.obs;
  RxBool isNameValid = true.obs;
  RxBool isTcknValid = true.obs;
  RxBool isSchoolValid = true.obs;

  bool loginValid() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String tckn = tcknController.text.trim();
    String phone = phoneController.text.trim();
    String school = schoolController.text.trim();

    String errorMessage = '';

    // E-mail validation
    if (email.isEmpty || !email.isEmail) {
      isEmailValid.value = false;
      errorMessage += 'Geçersiz e-posta. ';
    } else {
      isEmailValid.value = true;
    }

    // Password validation
    if (password.isEmpty || password.length < 8) {
      isPasswordValid.value = false;
      errorMessage += 'Şifre en az 8 karakter olmalı. ';
    } else {
      isPasswordValid.value = true;
    }

    // Name validation
    if (name.isEmpty || name.length < 2) {
      isNameValid.value = false;
      errorMessage += 'İsim en az 2 karakter olmalı. ';
    } else {
      isNameValid.value = true;
    }

    // TCKN validation
    if (tckn.isEmpty || tckn.length != 11) {
      isTcknValid.value = false;
      errorMessage += 'TCKN 11 haneli olmalı. ';
    } else {
      isTcknValid.value = true;
    }

    // Phone validation
    if (phone.isEmpty || !phone.isPhoneNumber) {
      isPhoneValid.value = false;
      errorMessage += 'Geçersiz telefon numarası. ';
    } else {
      isPhoneValid.value = true;
    }

    // School validation
    if (school.isEmpty) {
      isSchoolValid.value = false;
      errorMessage += 'Okul adı boş olamaz. ';
    } else {
      isSchoolValid.value = true;
    }

    // Eğer herhangi bir hata varsa, tüm hataları tek bir mesajda göster
    if (errorMessage.isNotEmpty) {
      Get.snackbar(
        "Hata",
        errorMessage.trim(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }

    return true;
  }
}
