import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';

class CreditCardInputController extends GetxController {
  TextEditingController cardNumberController =  MaskedTextController(mask: '0000-0000-0000-0000');
  final cvvController = TextEditingController();
  final nameController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  var isCheckboxChecked = false.obs;

  void clearAllFields() {
    cardNumberController.clear();
    cvvController.clear();
    nameController.clear();
    monthController.clear();
    yearController.clear();
    isCheckboxChecked.value = false;
  }

  final RxString formattedCardNumber = ''.obs;

  bool validateAndSubmit() {
    String name = nameController.text.trim();
    String cardNumber = cardNumberController.text.trim();
    String cvv = cvvController.text.trim();
    String month = monthController.text.trim();
    String year = yearController.text.trim();

    String errorMessage = '';

    // Tüm alanlar boşsa genel hata göster
    if (name.isEmpty &&
        cardNumber.isEmpty &&
        cvv.isEmpty &&
        month.isEmpty &&
        year.isEmpty &&
        !isCheckboxChecked.value) {
      Get.snackbar(
        "Hata",
        "Lütfen tüm alanları doldurunuz.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }

    // Ad kontrolü
    if (name.isEmpty || name.length < 2) {
      errorMessage += 'Ad en az 2 karakter olmalı. ';
    }
    if (cvv.isEmpty || cvv.length != 3) {
      errorMessage += 'CVV 3 karakter olmalı ';
    }
    if (month.isEmpty) {
      errorMessage += 'Ay  boş olmamalı ';
    }
    if (cardNumber.isEmpty || cardNumber.length != 19) {
      errorMessage += 'Kredi Kartı boş olmamalı   ';
    }

    // Soyad kontrolü
    if (year.isEmpty) {
      errorMessage += 'Yıl boş olmamalı ';
    }

    // Checkbox kontrolü
    if (!isCheckboxChecked.value) {
      errorMessage += 'Lütfen sözleşmeyi kabul edin. ';
    }

    if (errorMessage.isNotEmpty) {
      Get.snackbar(
        "Hata",
        errorMessage.trim(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    Get.snackbar(
      "Başarılı",
      "Ödeme Başarıyla Yapıldı",
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
    );
    return true;
  }
}
