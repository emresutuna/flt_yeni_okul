import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/SharedPrefHelper.dart';
import '../../../util/YOColors.dart';
import '../../../widgets/PrimaryButton.dart';
import '../../../widgets/PrimaryInputField.dart';
import '../../../widgets/WhiteAppBar.dart';
import '../bloc/PasswordUpdateBloc.dart';
import '../bloc/UserUpdateEvent.dart';
import '../bloc/UserUpdateState.dart';
import '../model/MailUpdateValidation.dart';
import '../model/PhoneUpdateValidation.dart';
import '../model/UserUpdateRequest.dart';

class PhoneUpdatePage extends StatefulWidget {
  const PhoneUpdatePage({super.key});

  @override
  State<PhoneUpdatePage> createState() => _PhoneUpdatePageState();
}

class _PhoneUpdatePageState extends State<PhoneUpdatePage> {
  PhoneUpdateValidation mailUpdateValidation = PhoneUpdateValidation();
  String? phoneNumber = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        phoneNumber = prefs.getString('user_phone') ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Telefon Numarası Güncelle"),
      body: SafeArea(
        child: BlocConsumer<PasswordUpdateBloc, UserUpdateState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              saveData(
                mailUpdateValidation.formatPhoneNumber(
                    mailUpdateValidation.phoneController.text),
                "user_phone",
              );
              Get.snackbar(
                "Başarılı",
                "Telefon Numarası Güncellendi",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        'Telefon numaranı değiştirerek güncelleyebilirsin.',
                        style: styleBlack12Regular,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrimaryInputField(
                          controller: mailUpdateValidation.phoneController,
                          hintText: "$phoneNumber",
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
                                        email: null,
                                        password: null,
                                        name: null,
                                        phone: mailUpdateValidation
                                            .formatPhoneNumber(
                                                mailUpdateValidation
                                                    .phoneController.text))));
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
