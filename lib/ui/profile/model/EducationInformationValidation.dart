import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationInformationValidation extends GetxController {
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolAddressController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  RxString schoolNameError = ''.obs;
  RxString schoolAddressError = ''.obs;
  RxString gradeError = ''.obs;

  bool updatePasswordValid() {
    String schoolName = schoolNameController.text.trim();
    String schoolAddress = schoolAddressController.text.trim();
    String grade = gradeController.text.trim();

    schoolNameError.value = '';
    schoolAddressError.value = '';
    gradeError.value = '';

    bool isValid =
        true;

    if (schoolName.isEmpty || schoolName.length <= 2) {
      schoolNameError.value = 'Okul Adı Boş Olamaz';
      isValid = false;
    }


    if (grade.isEmpty) {
      gradeError.value = 'Sınıf Bilgisi Boş Olamaz';
      isValid = false;
    }

    if (!isValid) {
      if (schoolNameError.value.isNotEmpty) {
        Get.snackbar("Hata", schoolNameError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      if (schoolAddressError.value.isNotEmpty) {
        Get.snackbar("Hata", schoolAddressError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      if (gradeError.value.isNotEmpty) {
        Get.snackbar("Hata", gradeError.value,
            colorText: Colors.white, backgroundColor: Colors.red);
      }
      return false;
    }

    return true;
  }
}
