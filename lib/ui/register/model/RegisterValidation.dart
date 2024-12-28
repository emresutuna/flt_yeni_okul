import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class RegisterValidation extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController tcknController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController =
      MaskedTextController(mask: '(000)-000-00-00');
  TextEditingController passwordController = TextEditingController();

  RxBool isEmailValid = true.obs;
  RxBool isPasswordValid = true.obs;
  RxBool isPhoneValid = true.obs;
  RxBool isNameValid = true.obs;
  RxBool isSurnameValid = true.obs;
  RxBool isTcknValid = true.obs;
  RxBool isPrivacyPolicyAccepted = false.obs;
  RxBool isPolicyAccepted = false.obs;

  void clearAllFields() {
    emailController.clear();
    surnameController.clear();
    tcknController.clear();
    nameController.clear();
    phoneController.clear();
    passwordController.clear();
    isEmailValid.value = true;
    isPasswordValid.value = true;
    isPhoneValid.value = true;
    isNameValid.value = true;
    isSurnameValid.value = true;
    isTcknValid.value = true;
    isPrivacyPolicyAccepted.value = false;
    isPolicyAccepted.value = false;
  }

  String formatPhoneNumber(String maskedPhoneNumber) {
    String rawPhone = maskedPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (rawPhone.length == 10) {
      return '+90$rawPhone';
    } else {
      throw FormatException("Geçersiz telefon numarası formatı");
    }
  }

  bool isValidTCKN(String tckn) {
    if (tckn.length != 11 || !RegExp(r'^[0-9]+$').hasMatch(tckn)) {
      return false;
    }
    int total = 0;
    for (int i = 0; i < 10; i++) {
      total += int.parse(tckn[i]);
    }
    int firstDigit = total % 10;
    if (firstDigit != int.parse(tckn[10])) {
      return false;
    }
    return true;
  }

  bool registerValid() {
    String email = emailController.text.trim();
    String surname = surnameController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String tckn = tcknController.text.trim();
    String phone = phoneController.text.trim();

    String errorMessage = '';

    if (email.isEmpty &&
        surname.isEmpty &&
        password.isEmpty &&
        name.isEmpty &&
        tckn.isEmpty &&
        phone.isEmpty) {
      Get.snackbar(
        "Hata",
        "Lütfen tüm alanları doldurunuz.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (email.isEmpty || !email.isEmail) {
      isEmailValid.value = false;
      errorMessage += 'Geçersiz e-posta. ';
    } else {
      isEmailValid.value = true;
    }

    if (password.isEmpty || password.length < 8) {
      isPasswordValid.value = false;
      errorMessage += 'Şifre en az 8 karakter olmalı. ';
    } else {
      isPasswordValid.value = true;
    }

    if (name.isEmpty || name.length < 2) {
      isNameValid.value = false;
      errorMessage += 'İsim en az 2 karakter olmalı. ';
    } else {
      isNameValid.value = true;
    }

    if (surname.isEmpty || surname.length < 1) {
      isSurnameValid.value = false;
      errorMessage += 'Soyisim en az 1 karakter olmalı. ';
    } else {
      isSurnameValid.value = true;
    }

    String cleanedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (cleanedPhone.isEmpty || cleanedPhone.length != 10) {
      isPhoneValid.value = false;
      errorMessage += 'Geçersiz telefon numarası. ';
    } else {
      isPhoneValid.value = true;
    }


    if (!isPrivacyPolicyAccepted.value) {
      errorMessage += 'Gizlilik politikası kabul edilmelidir. ';
    }

    if (!isPolicyAccepted.value) {
      errorMessage += 'Kullanım şartları kabul edilmelidir. ';
    }

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

  void updatePolicy(bool? value) {
    isPolicyAccepted.value = value ?? false;
  }

  void updatePrivacyPolicy(bool? value) {
    isPrivacyPolicyAccepted.value = value ?? false;
  }
}
