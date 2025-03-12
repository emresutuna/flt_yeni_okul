import 'package:baykurs/ui/forgotpassword/ForgotPasswordRequest.dart';
import 'package:baykurs/ui/forgotpassword/ForgotPasswordValidation.dart';
import 'package:baykurs/ui/forgotpassword/bloc/ForgotPasswordBloc.dart';
import 'package:baykurs/ui/forgotpassword/bloc/ForgotPasswordEvent.dart';
import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../util/YOColors.dart';
import '../../widgets/PrimaryInputField.dart';
import 'bloc/ForgotPasswordState.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  const ForgotPasswordEmailPage({super.key});

  @override
  State<ForgotPasswordEmailPage> createState() =>
      _ForgotPasswordEmailPageState();
}

class _ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final ForgotPasswordValidation forgotPasswordValidation =
      Get.put(ForgotPasswordValidation());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    forgotPasswordValidation.emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) async {
          if (state is ForgotPasswordSuccess) {
            Get.snackbar(
              "Başarılı",
              state.response.message ?? "Mail Adresinize sıfırlama bağlantısı iletildi",
              colorText: Colors.white,
              backgroundColor: Colors.green,
            );
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
          } else if (state is ForgotPasswordError) {
            Get.snackbar(
              "Hata",
              state.error,
              colorText: Colors.white,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: color2,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 32,
                      alignment: Alignment.centerLeft,
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Şifremi Unuttum",
                    style: styleBlack18Bold.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Kayıt esnasında verilmiş olan e-mail adresinizi yazınız.",
                    style: styleBlack14Regular,
                  ),
                  const SizedBox(height: 32),
                  PrimaryInputField(
                    controller: forgotPasswordValidation.emailController,
                    hintText: "E-Posta",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: state is ForgotPasswordLoading
                        ? Center(child: CircularProgressIndicator(color: color5,))
                        : PrimaryButton(
                      text: "Şifremi Sıfırla",
                      onPress: () {
                        context.read<ForgotPasswordBloc>().add(
                          ForgotPwd(request: ForgotPasswordRequest(email: forgotPasswordValidation.emailController.text)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
