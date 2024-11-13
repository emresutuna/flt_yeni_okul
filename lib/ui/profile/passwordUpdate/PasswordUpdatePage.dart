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
import '../../../widgets/PrimaryButton.dart';

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
                      const SizedBox(height: 24),
                      Text(
                        'Lorem ipsum dolar sit amet amet lorem ipsum dolar amet lorem ipsum amet dolar sit amet.',
                        style: styleBlack12Regular,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: updateValidation.oldPwdController,
                          cursorColor: color1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            hintText: 'Mevcut Şifre',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: color2.withAlpha(75),
                              fontWeight: FontWeight.w400,
                            ),
                            labelStyle: TextStyle(
                                color: color1, fontWeight: FontWeight.bold),
                            focusColor: color2,
                            focusedBorder: const UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: color1,
                          controller: updateValidation.newPwdController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            hintText: 'Yeni Şifre',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: color2.withAlpha(75),
                              fontWeight: FontWeight.w400,
                            ),
                            labelStyle: TextStyle(
                                color: color1, fontWeight: FontWeight.bold),
                            focusColor: color2,
                            focusedBorder: const UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          cursorColor: color1,
                          controller: updateValidation.rePwdController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            hintText: 'Yeni Şifre Tekrar',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: color2.withAlpha(75),
                              fontWeight: FontWeight.w400,
                            ),
                            labelStyle: TextStyle(
                                color: color1, fontWeight: FontWeight.bold),
                            focusColor: color2,
                            focusedBorder: const UnderlineInputBorder(),
                          ),
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
