import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailUpdateValidation extends GetxController {
  TextEditingController oldMailController = TextEditingController();
  TextEditingController newMailController = TextEditingController();

  RxString oldMailError = ''.obs;
  RxString newMailError = ''.obs;

  bool updatePasswordValid() {
    String oldMail = oldMailController.text.trim();
    String newMail = newMailController.text.trim();

    oldMailError.value = '';
    newMailError.value = '';

    bool isValid = true;

    if (oldMail.isEmpty || !oldMail.isEmail) {
      oldMailError.value = 'Lütfen eski mail adresiniz kontrol edin';
      isValid = false;
    }
    if (newMail.isEmpty || !newMail.isEmail || newMail == oldMail) {
      newMailError.value = 'Lütfen yeni mail adresiniz kontrol edin';
      isValid = false;
    }

    if (!isValid) {
      if (oldMailError.value.isNotEmpty) {
        Get.snackbar("Hata", oldMailError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      if (newMailError.value.isNotEmpty) {
        Get.snackbar("Hata", newMailError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      return false;
    }

    return true;
  }
}
