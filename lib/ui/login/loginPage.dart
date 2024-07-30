import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/ui/login/model/UserLoginModel.dart';
import 'package:yeni_okul/ui/login/viewModel/loginVm.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/util/SharedPref.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'package:yeni_okul/widgets/PrimaryButton.dart';
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

  UserLoginModel userLoginModel = UserLoginModel();
  LoginVm loginVm = LoginVm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color4,
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
                return Center(
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
                              'assets/yeni_okul_logo_v2.png',
                              height:
                                  MediaQuery.of(context).size.height / 3.5,
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                cursorColor: color1,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: color2.withAlpha(75),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelStyle: TextStyle(
                                      color: color1,
                                      fontWeight: FontWeight.bold),
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
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  hintText: 'Şifre',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: color2.withAlpha(75),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  labelStyle: TextStyle(
                                      color: color1,
                                      fontWeight: FontWeight.bold),
                                  focusColor: color2,
                                  focusedBorder: const UnderlineInputBorder(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/forgotPasswordEmail');
                                    },
                                    child: YoText(
                                      text: "Şifremi Unuttum",
                                      color: color5,
                                      isUnderLine: true,
                                    )),
                              ],
                            ),
                            const SizedBox(height: 24),
                            PrimaryButton(
                                text: "Giriş Yap",
                                onPress: () => submitForm()),
                            const SizedBox(
                              height: 16,
                            ),
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
                                    Navigator.pushNamed(
                                        context, '/registerPage');
                                  },
                                  child: const YoHexText(
                                    text: "Kayıt Ol",
                                    fontWeight: FontWeight.bold,
                                    color: "FD275F",
                                  )),
                            ),
                          ],
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

    Navigator.pushReplacementNamed(
        context, '/mainPage');


     /*
    if (state!.validate()) {
      state.save();
      loginVm.loginServ("mehmetnky@gmail.com", "fS7LN073w4jmfD1Q73Z2");


      */


  }
}
