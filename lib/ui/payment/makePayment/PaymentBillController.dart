import 'package:baykurs/ui/payment/makePayment/model/PaymentBillModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  final TextEditingController adController = TextEditingController();
  final TextEditingController soyadController = TextEditingController();
  final TextEditingController tcKimlikController = TextEditingController();
  final TextEditingController dogumYiliController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController billNameController = TextEditingController();

  var selectedIl = "İstanbul";
  var selectedIlce = "Kadıköy";
  var isCheckboxChecked = false.obs; // Checkbox durumunu tutar

  final List<String> iller = ['İstanbul', 'Ankara', 'İzmir'];
  final List<String> ilceler = ['Kadıköy', 'Üsküdar', 'Beşiktaş'];

  void clearAllFields() {
    emailController.clear();
    soyadController.clear();
    tcKimlikController.clear();
    dogumYiliController.clear();
    emailController.clear();
    addressController.clear();
    billNameController.clear();
    isCheckboxChecked.value = false;
  }

  PaymentBillModel setupPaymentBill() {
    final paymentBill = PaymentBillModel(
      name: adController.text,
      surname: soyadController.text,
      email: emailController.text,
      tckn: tcKimlikController.text,
      birthday: dogumYiliController.text,
      address: addressController.text,
      billName: billNameController.text, city: "İstanbul", province: "Kadıköy",
    );
    paymentBill.saveToPreferences();
    return paymentBill;
  }


  bool validateAndSubmit() {
    String ad = adController.text.trim();
    String soyad = soyadController.text.trim();
    String tcKimlik = tcKimlikController.text.trim();
    String dogumYili = dogumYiliController.text.trim();
    String email = emailController.text.trim();
    String address = addressController.text.trim();
    String billName = billNameController.text.trim();

    String errorMessage = '';

    // Tüm alanlar boşsa genel hata göster
    if (ad.isEmpty &&
        soyad.isEmpty &&
        tcKimlik.isEmpty &&
        dogumYili.isEmpty &&
        email.isEmpty &&
        address.isEmpty &&
        billName.isEmpty &&
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
    if (ad.isEmpty || ad.length < 2) {
      errorMessage += 'Ad en az 2 karakter olmalı. ';
    }
    if (address.isEmpty || address.length < 2) {
      errorMessage += 'Adres boş olmamalı ';
    }
    if (billName.isEmpty) {
      errorMessage += 'Fatura Adı boş olmamalı ';
    }

    // Soyad kontrolü
    if (soyad.isEmpty || soyad.length < 1) {
      errorMessage += 'Soyad en az 1 karakter olmalı. ';
    }

    // TC Kimlik kontrolü
    if (tcKimlik.isEmpty ||
        tcKimlik.length != 11 ||
        !RegExp(r'^\d+$').hasMatch(tcKimlik)) {
      errorMessage += 'Geçersiz TC Kimlik No. ';
    }

    // Doğum yılı kontrolü
    if (dogumYili.isEmpty || int.tryParse(dogumYili) == null) {
      errorMessage += 'Geçersiz doğum yılı. ';
    }

    // E-posta kontrolü
    if (email.isEmpty || !email.isEmail) {
      errorMessage += 'Geçersiz e-posta adresi. ';
    }

    // Checkbox kontrolü
    if (!isCheckboxChecked.value) {
      errorMessage += 'Lütfen sözleşmeyi kabul edin. ';
    }

    // Hata mesajı varsa göster ve false döndür
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
      "Bilgiler kaydedildi.",
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
    );
    return true;
  }
}
