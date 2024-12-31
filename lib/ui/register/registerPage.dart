import 'package:baykurs/ui/register/model/RegisterValidation.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/PhoneFormatter.dart';
import 'package:baykurs/widgets/PrimaryInputField.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../util/SimpleStream.dart';
import '../../util/YOColors.dart';
import '../../widgets/PasswordField.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/YOText.dart';
import '../login/UserRole.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../webViewPage/WebViewPage.dart';
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
      appBar: WhiteAppBar("Hesap Oluştur", onTap: () {
        Navigator.pop(context);
      }, canGoBack: true),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Get.snackbar(
              "Başarılı",
              "Kayıt işlemi başarılı",
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
            Navigator.pushReplacementNamed(context, '/emailActivationInfoPage');
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
            Text(
              "Kayıt olarak özgün eğitim modeliyle tanış, başarıya doğru ilk adımını at.",
              style: styleBlack14Regular,
            ),
            16.toHeight,
            PrimaryInputField(
              controller: registerValidation.nameController,
              hintText: 'Ad',
              keyboardType: TextInputType.name,
            ),
            PrimaryInputField(
              controller: registerValidation.surnameController,
              hintText: 'Soyad',
              keyboardType: TextInputType.name,
            ),
            PrimaryInputField(
              controller: registerValidation.emailController,
              hintText: 'E-Posta',
              keyboardType: TextInputType.emailAddress,
            ),
            PrimaryInputField(
              controller: registerValidation.phoneController,
              hintText: 'Telefon Numarası',
              keyboardType: TextInputType.phone,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordField(
                controller: registerValidation.passwordController,
                hint: "Şifre",
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
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Gizlilik Politikası ",
                          style: styleBlack10Regular.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: color5,
                              color: color5),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openWebView('https://www.bykurs.com.tr/privacy',
                                  'Gizlilik Politakası');
                            },
                          children: [
                            TextSpan(
                                text: "metnini okudum ve kabul ediyorum.",
                                style: styleBlack10Regular.copyWith(
                                    decoration: TextDecoration.none)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
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
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Kullanım Şartları ",
                          style: styleBlack10Regular.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: color5,
                              color: color5),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openWebView(
                                  'https://www.bykurs.com.tr/personal-data',
                                  'Kişisel Veriler');
                            },
                          children: [
                            TextSpan(
                                text: "metnini okudum ve kabul ediyorum.",
                                style: styleBlack10Regular.copyWith(
                                    decoration: TextDecoration.none)),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),
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
                          ),
                        ),
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
