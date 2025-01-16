import 'package:baykurs/ui/profile/bloc/PasswordUpdateBloc.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateEvent.dart';
import 'package:baykurs/ui/profile/bloc/UserUpdateState.dart';
import 'package:baykurs/ui/profile/model/MailUpdateValidation.dart';
import 'package:baykurs/ui/profile/model/UserUpdateRequest.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../util/YOColors.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/PrimaryInputField.dart';

class MailUpdatePage extends StatefulWidget {
  const MailUpdatePage({super.key});

  @override
  State<MailUpdatePage> createState() => _MailUpdatePageState();
}

class _MailUpdatePageState extends State<MailUpdatePage> {
  MailUpdateValidation mailUpdateValidation = MailUpdateValidation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("E-mail Güncelle"),
      body: SafeArea(
        child: BlocConsumer<PasswordUpdateBloc, UserUpdateState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              Get.snackbar(
                "Başarılı",
                "Mail Adresi Güncellendi, e-postanıza gelen aktivasyon ile birlikte  aktivasyon yapınız",
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
                        child: PrimaryInputField(
                          controller: mailUpdateValidation.oldMailController,
                        hintText: "Mevcut Email",
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrimaryInputField(
                          controller: mailUpdateValidation.newMailController,
                          hintText: "Yeni Email",
                        ),
                      ),
                      const SizedBox(height: 32),
                      PrimaryButton(
                        text: "Güncelle",
                        onPress: () {
                          if (mailUpdateValidation.updatePasswordValid()) {
                            context.read<PasswordUpdateBloc>().add(
                                UserUpdateRequest(
                                    request: UserUpdateRequestModel(
                                        email: mailUpdateValidation
                                            .newMailController.text,
                                        password: null,
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
                    child:  Center(
                      child: CircularProgressIndicator(color: color5,),
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
