import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_text_box/flutter_text_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/ui/login/model/UserLoginModel.dart';
import 'package:yeni_okul/ui/login/services/AuthServices.dart';
import 'package:yeni_okul/ui/login/viewModel/loginVm.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/util/SharedPref.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'package:yeni_okul/widgets/YOText.dart';

import '../../widgets/YoHexText.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final key = GlobalKey<FormState>();
  final StreamController<bool> _loadingController = StreamController();


  Stream<bool> get _loadingStream => _loadingController.stream;
  UserLoginModel userLoginModel = UserLoginModel(email: "", password: "");
  LoginVm loginVm = LoginVm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder<LoginUiState>(
              stream: loginVm.loginUiState,
              builder: (context, snapshot) {
                if (snapshot.data is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data is LoginError) {
                  showError();
                }
                return Container(
                  decoration: gradient,
                  child: Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, top: 0, right: 16, bottom: 0),
                        child: Form(
                          key: key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/yeni_okul_logo.png',
                                height: 100,
                              ),
                              const SizedBox(height: 16),
                              TextBoxLabel(
                                label: 'E-mail',
                                hint: 'E-mailinizi girin',
                                errorText: 'Bu alan zorunludur!',
                                onSaved: (String value) {
                                  userLoginModel.email = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextBoxIcon(
                                  icon: Icons.lock_outlined,
                                  inputType: TextInputType.number,
                                  obscure: true,
                                  label: 'Şifre',
                                  hint: 'Şifrenizi girin',
                                  errorText: 'Bu alan zorunludur!',
                                  onSaved: (String value) {
                                    userLoginModel.password = value;
                                  }),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/forgotPasswordEmail');
                                      },
                                      child: const YoText(
                                        text: "Şifremi Unuttum",
                                        isUnderLine: true,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: HexColor("#1A1348"),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 18),
                                      textStyle: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () => submitForm(),
                                    child: const YoText(
                                      text: "Giriş Yap",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                      side: BorderSide(
                                        width: 2.0,
                                        color: HexColor("#1A1348"),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 18),
                                      textStyle: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/userRolePage');
                                    },
                                    child: const YoHexText(
                                      text: "Kayıt Ol",
                                      fontWeight: FontWeight.bold,
                                      color: "1A1348",
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  showError() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.bottomSlide,
        headerAnimationLoop: false,
        title: 'Hata',
        desc: "Bir Hata OLuştu",
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red,
      ).show();
    });
  }

  loadState(dynamic data) {
    if (data != null) {
      if (data is PlatformException) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          headerAnimationLoop: false,
          title: 'Hata',
          desc: data.toString(),
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red,
        ).show();
      } else {
        _loadingController.sink.add(false);
        debugPrint((data as User).email);
        PreferenceUtils.setString("user", data.uid);
        Navigator.pushNamed(context, '/mainPage',
            arguments: {'userName': data});
      }
      _loadingController.sink.add(false);
    }
  }

  submitForm() {
    final state = key.currentState;
    AuthService authService = AuthService();
    /*
    authService.signUpUser(UserRegisterModel(
        id: "",
        name: "emre",
        email: "emre.sutuna1998@gmail.com",
        surname: "Sutuna",
        phone: "53455345",
        password: "emre1234",
        userRole: UserRole.ADMIN,
        companyCode: null, createdDate: DateTime.timestamp()
    )
    );

     */
    Navigator.pushReplacementNamed(
        context, '/mainPage');

    if (state!.validate()) {
      state.save();
      loginVm.loginServ("mehmetnky@gmail.com", "fS7LN073w4jmfD1Q73Z2");
      /*
      _loadingController.sink.add(true);
      authService
          .signInWithEmailAndPassword(
              userLoginModel.email, userLoginModel.password)
          .then((value) => loadState(value));

       */
    }
  }
}
