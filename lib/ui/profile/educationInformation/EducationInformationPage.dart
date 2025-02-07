import 'package:baykurs/ui/profile/bloc/EducationInformationState.dart';
import 'package:baykurs/ui/profile/model/EducationInformationRequest.dart';
import 'package:baykurs/ui/profile/model/EducationInformationResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../util/LessonExtension.dart';
import '../../../util/YOColors.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/PrimaryInputField.dart';
import '../../../widgets/WhiteAppBar.dart';
import '../bloc/EducationInformationBloc.dart';
import '../bloc/EducationInformationEvent.dart';
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
  EducationInformationResponse educationInformation =
      EducationInformationResponse();

  @override
  void initState() {
    super.initState();
    context.read<EducationInformationBloc>().add(FetchEducationInformation());
  }

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
        }, builder: (context, state) {
          if (state is EducationInformationStateLoading) {
            return Stack(
              children: [
                pageContent(),
                Container(
                  color: Colors.white60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: color5,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is EducationInformationStateSuccess) {
            educationInformation = state.educationInformationResponse;
            updateValidation.setExistingInformation(educationInformation);
          }
          return pageContent();
        }),
      ),
    );
  }

  pageContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
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
              hintText: "Okul Adresi",
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder<ClassTypes?>(
                    valueListenable: updateValidation.selectedGrade,
                    builder: (context, selectedGrade, child) {
                      return DropdownButtonFormField<ClassTypes>(
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
                        items: ClassTypes.values.map((ClassTypes grade) {
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
                          updateValidation.selectedGrade.value = newValue;
                          if (newValue != null) {
                            updateValidation.gradeController.text =
                                newValue.value;
                          }
                        },
                        hint: const Text(
                          'Sınıf Seç',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        value: selectedGrade,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            text: "Güncelle",
            onPress: () {
              if (!updateValidation.isUpdated()) {
                Get.snackbar(
                  "Hata",
                  "Herhangi bir değişiklik yapılmadı.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                );
                return;
              }
              if (updateValidation.isValid()) {
                EducationInformationRequest request =
                    updateValidation.getUpdatedRequest();
                context.read<EducationInformationBloc>().add(
                      UpdateEducationInformation(request: request),
                    );
              }
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
