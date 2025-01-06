import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/LessonExtension.dart';
import '../model/EducationInformationResponse.dart';
import 'EducationInformationRequest.dart';

class EducationInformationValidation extends GetxController {
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController schoolAddressController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  ValueNotifier<ClassTypes?> selectedGrade = ValueNotifier<ClassTypes?>(null);

  RxString errorMessage = ''.obs;

  EducationInformationResponse? existingInformation;
  EducationInformationResponse? initialInformation;

  void setExistingInformation(EducationInformationResponse info) {
    existingInformation = info;
    initialInformation = EducationInformationResponse(
      educationInfo: info.educationInfo != null
          ? EducationInfo(
        schoolName: info.educationInfo?.schoolName,
        schoolAddress: info.educationInfo?.schoolAddress,
        grade: info.educationInfo?.grade,
      )
          : null,
    );

    schoolNameController.text = info.educationInfo?.schoolName ?? '';
    schoolAddressController.text = info.educationInfo?.schoolAddress ?? '';
    gradeController.text = info.educationInfo?.grade ?? '';

    selectedGrade.value = ClassTypesExtension.fromDisplay(
        info.educationInfo?.grade ?? '');

  }

  bool isValid() {
    String schoolName = schoolNameController.text.trim();
    String schoolAddress = schoolAddressController.text.trim();
    String grade = gradeController.text.trim();

    errorMessage.value = '';

    if (schoolName.isEmpty || schoolName.length <= 2) {
      errorMessage.value = 'Lütfen tüm alanları doldurun.';
    }

    if (schoolAddress.isEmpty || schoolAddress.length <= 2) {
      errorMessage.value = 'Lütfen tüm alanları doldurun.';
    }

    if (grade.isEmpty) {
      errorMessage.value = 'Lütfen tüm alanları doldurun.';
    } else {
      int? gradeValue =
      ClassTypesExtension.getGradeValueFromDisplay(grade.trim());
      if (gradeValue == null) {
        errorMessage.value = 'Lütfen tüm alanları doldurun.';
      }
    }

    if (errorMessage.value.isNotEmpty) {
      Get.snackbar(
        "Hata",
        errorMessage.value,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    }

    return true;
  }

  EducationInformationRequest getUpdatedRequest() {
    int? gradeValue =
    ClassTypesExtension.getGradeValueFromDisplay(gradeController.text.trim());

    return EducationInformationRequest(
      schoolName: schoolNameController.text.trim(),
      schoolAddress: schoolAddressController.text.trim(),
      grade: gradeValue?.toString(),
    );
  }

  bool isUpdated() {
    if (initialInformation == null || initialInformation?.educationInfo == null) {
      return false;
    }

    final initialInfo = initialInformation!.educationInfo;
    final currentInfo = EducationInfo(
      schoolName: schoolNameController.text.trim(),
      schoolAddress: schoolAddressController.text.trim(),
      grade: gradeController.text.trim(),
    );

    bool isSchoolNameUpdated =
        currentInfo.schoolName != initialInfo?.schoolName;
    bool isSchoolAddressUpdated =
        currentInfo.schoolAddress != initialInfo?.schoolAddress;
    bool isGradeUpdated = currentInfo.grade != initialInfo?.grade;


    if (!isSchoolNameUpdated && !isSchoolAddressUpdated && !isGradeUpdated) {
      return false;
    }

    return isSchoolNameUpdated || isSchoolAddressUpdated || isGradeUpdated;
  }
}
