import 'package:baykurs/util/FirebaseAnalyticsManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/FirebaseAnalyticsConstants.dart';
import '../../util/GlobalLoading.dart';
import '../../util/YOColors.dart';
import '../../widgets/PasswordField.dart';
import '../../widgets/PrimaryButton.dart';
import '../../widgets/PrimaryInputField.dart';
import 'loginBloc/login_bloc.dart';
import 'loginBloc/login_event.dart';
import 'loginBloc/login_state.dart';
import 'model/login_request.dart';
import 'model/login_validation.dart';
import 'model/user_login_model.dart';

class LoginPage extends StatefulWidget {
  final bool showClose;

  const LoginPage({super.key, required this.showClose});

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
      appBar: AppBar(
        backgroundColor: Colors.white, // Beyaz arka plan
        elevation: 0, // Gölgelendirme yok
        automaticallyImplyLeading: false, // Geri butonunu kaldır
        actions: widget.showClose
            ? [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.clear,size: 16,),
                      )),
                ),
              ),
            ),
              ]
            : null,
      ),
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
              return const GlobalFadeAnimation();
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
                              FirebaseAnalyticsManager.logEvent(FirebaseAnalyticsConstants.user_register);

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
