import 'package:baykurs/ui/profile/bloc/EducationInformationState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../util/LessonExtension.dart';
import '../../../util/YOColors.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/PrimaryInputField.dart';
import '../../../widgets/WhiteAppBar.dart';
import '../bloc/EducationInformationBloc.dart';
import '../bloc/UserUpdateState.dart';
import '../model/EducationInformationValidation.dart';

class EducationInformationPage extends StatefulWidget {
  const EducationInformationPage({super.key});

  @override
  State<EducationInformationPage> createState() =>
      _EducationInformationPageState();
}

class _EducationInformationPageState extends State<EducationInformationPage> {
  EducationInformationValidation updateValidation =
      EducationInformationValidation();
  ClassTypes? selectedGrade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Eğitim Bilgileri"),
      body: SafeArea(
        child:
            BlocConsumer<EducationInformationBloc, EducationInformationState>(
          listener: (context, state) {
            if (state is EducationInformationStateUpdateSuccess) {
              Get.snackbar(
                "Başarılı",
                "Eğitim Bilgileri Güncellendi",
                colorText: Colors.white,
                backgroundColor: Colors.green,
              );
            } else if (state is EducationInformationStateUpdateError) {
              Get.snackbar(
                "Hata",
                state.error,
                colorText: Colors.white,
                backgroundColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Lorem ipsum dolar sit amet amet lorem ipsum dolar amet lorem ipsum amet dolar sit amet.',
                        style: styleBlack12Regular,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrimaryInputField(
                          controller: updateValidation.schoolNameController,
                          hintText: "Okul Adı",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrimaryInputField(
                          controller: updateValidation.schoolAddressController,
                          hintText: "Okul Adresi (Opsiyonel)",
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<ClassTypes>(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(color: color1),
                                  ),
                                ),
                                items:
                                    ClassTypes.values.map((ClassTypes grade) {
                                  return DropdownMenuItem<ClassTypes>(
                                    value: grade,
                                    child: Text(
                                      grade.value,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      maxLines: 1,
                                      style: styleBlack14Bold,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (ClassTypes? newValue) {
                                  setState(() {
                                    selectedGrade = newValue;
                                    if (newValue != null) {
                                      updateValidation.gradeController.text =
                                          newValue.value;
                                    }
                                  });
                                },
                                hint: const Text(
                                  'Sınıf Seç',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                value: selectedGrade,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: "Güncelle",
                        onPress: () {
                          if (updateValidation.updatePasswordValid()) {}
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                if (state is UserUpdateLoading)
                  Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
