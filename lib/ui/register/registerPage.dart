import 'package:baykurs/ui/register/model/RegisterValidation.dart';
import 'package:baykurs/util/PhoneFormatter.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';

import '../../util/SimpleStream.dart';
import '../../util/YOColors.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/YOText.dart';
import '../login/UserRole.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'bloc/RegisterBloc.dart';
import 'bloc/RegisterEvent.dart';
import 'bloc/RegisterState.dart';

import 'model/RegisterRequest.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  UserRole? userRole;
  bool privacyPolicy = false;
  bool smsPolicy = false;
  SimpleStream<bool> checkStream = SimpleStream<bool>();
  final RegisterValidation registerValidation = Get.put(RegisterValidation());

  bool get check => checkStream.current ?? false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    registerValidation.clearAllFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
      appBar:WhiteAppBar("Hesap Oluştur"),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Get.snackbar(
              "Başarılı",
              "Kayıt işlemi başarılı",
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
            Navigator.pushReplacementNamed(context, '/mainPage');
          } else if (state is RegisterError) {
            Get.snackbar(
              "Hata",
              state.error,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return Stack(
              children: [
                _buildForm(context),
                const Center(child: CircularProgressIndicator()),
              ],
            );
          }
          return _buildForm(context);
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            YoText(
              text:
                  "Kayıt olarak özgün eğitim modeliyle tanış, başarıya doğru ilk adımını at.",
              size: 12,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
              color: color2,
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: registerValidation.nameController,
                cursorColor: color1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText: 'Ad',
                  hintStyle:
                      TextStyle(fontSize: 16, color: color2.withAlpha(75)),
                  focusedBorder: const UnderlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: registerValidation.surnameController,
                cursorColor: color1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText: 'Soyad',
                  hintStyle:
                      TextStyle(fontSize: 16, color: color2.withAlpha(75)),
                  focusedBorder: const UnderlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: registerValidation.emailController,
                cursorColor: color1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText: 'Email',
                  hintStyle:
                      TextStyle(fontSize: 16, color: color2.withAlpha(75)),
                  focusedBorder: const UnderlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: registerValidation.phoneController,
                cursorColor: color1,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText: 'Telefon No',
                  hintStyle:
                      TextStyle(fontSize: 16, color: color2.withAlpha(75)),
                  focusedBorder: const UnderlineInputBorder(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: registerValidation.passwordController,
                obscureText: true,
                cursorColor: color1,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText: 'Şifre',
                  hintStyle:
                      TextStyle(fontSize: 16, color: color2.withAlpha(75)),
                  focusedBorder: const UnderlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    activeColor: color5,
                    value: registerValidation.isPolicyAccepted.value,
                    onChanged: (bool? value) {
                      registerValidation.updatePolicy(value);
                    },
                  ),
                ),
                const Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      YoText(
                        text:
                            "Gizlilik Politikasını ve Kullanım Şartlarını kabul ediyorum.",
                        size: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Obx(
                  () => Checkbox(
                    activeColor: color5,
                    value: registerValidation.isPrivacyPolicyAccepted.value,
                    onChanged: (bool? value) {
                      registerValidation.updatePrivacyPolicy(value);
                    },
                  ),
                ),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      alignment: WrapAlignment.start,
                      children: [
                        YoText(
                          text:
                              "Gizlilik Politikasını ve Kullanım Şartlarını kabul ediyorum.",
                          size: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Kayıt Ol butonu
            PrimaryButton(
              text: "Kayıt Ol",
              onPress: () {
                if (registerValidation.registerValid()) {
                  context.read<RegisterBloc>().add(
                        UserRegister(
                          request: RegisterRequest(
                            name: registerValidation.nameController.text,
                            surname: registerValidation.surnameController.text,
                            email: registerValidation.emailController.text,
                            phone: registerValidation.formatPhoneNumber(
                                registerValidation.phoneController.text),
                            password:
                                registerValidation.passwordController.text,
                            tckn: "12345678901",
                          ),
                        ),
                      );
                } else {
                  Get.snackbar(
                    "Uyarı",
                    "Lütfen Gizlilik Politikası ve Kullanım Şartlarını kabul edin.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
