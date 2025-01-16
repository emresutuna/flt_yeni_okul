import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/YOColors.dart';
import '../../widgets/PasswordField.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/PrimaryInputField.dart';
import '../../widgets/YOText.dart';
import 'loginBloc/LoginBloc.dart';
import 'loginBloc/LoginEvent.dart';
import 'loginBloc/LoginState.dart';
import 'model/LoginRequest.dart';
import 'model/LoginValidation.dart';
import 'model/UserLoginModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();
  UserLoginModel userLoginModel = UserLoginModel();
  final LoginValidation loginValidation = Get.put(LoginValidation());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginValidation.emailController.clear();
    loginValidation.passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, '/mainPage');
            } else if (state is LoginError) {
              Get.snackbar(
                "Hata",
                "Kullanıcı adı veya şifre yanlış",
                colorText: Colors.white,
                backgroundColor: Colors.red,
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return  Center(child: CircularProgressIndicator(color: color5,));
            }
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 0, right: 16, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/baykurs_main_logo.png',
                        height: MediaQuery.of(context).size.height / 3.5,
                      ),
                      const SizedBox(height: 16),
                      PrimaryInputField(
                        padding: const EdgeInsets.all(0),
                        controller: loginValidation.emailController,
                        hintText: 'E-Posta',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 8),
                      PasswordField(
                        controller: loginValidation.passwordController,
                        hint: "Şifre",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/forgotPasswordEmail');
                              },
                              child: Text(
                                "Şifremi Unuttum",
                                style: styleBlack14Regular.copyWith(
                                    color: color5,
                                    decoration: TextDecoration.underline,
                                    decorationColor: color5),
                              )),
                        ],
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        text: "Giriş Yap",
                        onPress: () {
                          if (loginValidation.loginValid()) {
                            context.read<LoginBloc>().add(
                                  UserLogin(
                                    request: LoginRequest(
                                      email:
                                          loginValidation.emailController.text,
                                      password: loginValidation
                                          .passwordController.text,
                                      remember: 0,
                                    ),
                                  ),
                                );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              elevation: 0,
                              side: BorderSide.none,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 18),
                              textStyle: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/registerPage');
                            },
                            child: Text(
                              "Kayıt Ol",
                              style: styleBlack14Bold.copyWith(color: color5),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
