import 'package:baykurs/ui/profile/bloc/PasswordUpdateBloc.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateEvent.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateState.dart';
import 'package:baykurs/ui/profile/model/UserUpdateRequest.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baykurs/ui/profile/model/PasswordUpdateValidation.dart';
import 'package:get/get.dart';
import '../../../util/YOColors.dart';
import '../../../widgets/PasswordField.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/PrimaryInputField.dart';

class PasswordUpdatePage extends StatefulWidget {
  const PasswordUpdatePage({super.key});

  @override
  State<PasswordUpdatePage> createState() => _PasswordUpdatePageState();
}

class _PasswordUpdatePageState extends State<PasswordUpdatePage> {
  PasswordUpdateValidation updateValidation = PasswordUpdateValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Şifre Güncelle"),
      body: SafeArea(
        child: BlocConsumer<PasswordUpdateBloc, UserUpdateState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              Get.snackbar(
                "Başarılı",
                "Parola Güncellendi",
                colorText: Colors.white,
                backgroundColor: Colors.green,
              );
            } else if (state is UserUpdateError) {
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
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PasswordField(
                          controller: updateValidation.oldPwdController,
                          hint: "Mevcut Şifre",
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PasswordField(
                          controller: updateValidation.newPwdController,
                          hint: "Yeni Şifre",
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PasswordField(
                          controller: updateValidation.rePwdController,
                          hint: "Yeni Şifre Tekrar",
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: "Güncelle",
                        onPress: () {
                          if (updateValidation.updatePasswordValid()) {
                            context.read<PasswordUpdateBloc>().add(
                                UserUpdateRequest(
                                    request: UserUpdateRequestModel(
                                        password: updateValidation
                                            .rePwdController.text,
                                        name: null,
                                        phone: null)));
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                if (state is UserUpdateLoading)
                  Container(
                    color: Colors.grey.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: color5,
                      ),
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
