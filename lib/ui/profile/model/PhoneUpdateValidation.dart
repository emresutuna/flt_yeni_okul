import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class PhoneUpdateValidation extends GetxController {
  TextEditingController phoneController =
      MaskedTextController(mask: '(000)-000-00-00');
  String oldPhone = "";

  RxBool isPhoneValid = true.obs;

  void clearPhoneUpdate() {
    phoneController.clear();
    isPhoneValid.value = true;
  }

  String formatPhoneNumber(String maskedPhoneNumber) {
    String rawPhone = maskedPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (rawPhone.length == 10) {
      return '+90$rawPhone';
    } else {
      throw const FormatException("Geçersiz telefon numarası formatı");
    }
  }

  bool updatePasswordValid() {
    bool isValid = true;
    String phone = phoneController.text.trim();

    String cleanedPhone = phone.replaceAll(RegExp(r'\D'), '');
    if (cleanedPhone.isEmpty || cleanedPhone.length != 10) {
      isPhoneValid.value = false;
      Get.snackbar("Hata", "Geçersiz telefon numarası.",
          colorText: Colors.white, backgroundColor: Colors.red);
      isValid = false;
    } else if (phone == oldPhone) {
      isPhoneValid.value = false;
      Get.snackbar("Hata", "Eski telefon numarasıyla aynı olamaz.",
          colorText: Colors.white, backgroundColor: Colors.red);
      isValid = false;
    } else {
      isPhoneValid.value = true;
      isValid = true;
    }

    return isValid;
  }
}
