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
    }

    if (rawPhone.startsWith('90') && rawPhone.length == 12) {
      return '+$rawPhone';
    }

    if (rawPhone.startsWith('0') && rawPhone.length == 11) {
      return '+90${rawPhone.substring(1)}';
    }

    throw const FormatException("Geçersiz telefon numarası formatı");
  }

  String cleanPhoneNumber(String phoneNumber) {
    String rawPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (rawPhone.startsWith('90') && rawPhone.length >= 12) {
      rawPhone = rawPhone.substring(2);
    }

    if (rawPhone.startsWith('0') && rawPhone.length >= 11) {
      rawPhone = rawPhone.substring(1);
    }
    return rawPhone;
  }

  String formatAsMaskedPhone(String phoneNumber) {
    String rawPhone = cleanPhoneNumber(phoneNumber);

    if (rawPhone.length != 10) {
      throw const FormatException("Geçersiz telefon numarası uzunluğu");
    }

    String part1 = rawPhone.substring(0, 3);
    String part2 = rawPhone.substring(3, 6);
    String part3 = rawPhone.substring(6, 8);
    String part4 = rawPhone.substring(8, 10);

    return '($part1)-$part2-$part3-$part4';
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
