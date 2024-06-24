import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/ui/login/UserRole.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/widgets/YOText.dart';
import 'package:yeni_okul/widgets/YoHexText.dart';
import 'package:flutter_text_box/flutter_text_box.dart';

class UserRolePage extends StatefulWidget {
  const UserRolePage({super.key});

  @override
  State<UserRolePage> createState() => _UserRolePageState();
}

class _UserRolePageState extends State<UserRolePage> {
  final StreamController<UserRole> _checkBoxController = StreamController();

  Stream<UserRole> get _checkBoxStream => _checkBoxController.stream;
  var userRole = UserRole.STUDENT;

  @override
  void dispose() {
    _checkBoxController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(100, 141, 153, 202),
              Color.fromARGB(100, 141, 153, 202),
              Color.fromARGB(90, 141, 153, 202),
              Color.fromARGB(53, 141, 153, 202),
              Color.fromARGB(34, 141, 153, 202),
              Color.fromARGB(0, 141, 153, 202),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, top: 32, right: 0, bottom: 0),
                child: IconButton(
                  color: HexColor("#1A1348"),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 32,
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const YoHexText(
                text: "Hesap Oluştur",
                size: 20,
                fontWeight: FontWeight.bold,
                color: "#1A1348",
              ),
              const SizedBox(
                height: 16,
              ),
              const YoHexText(
                text:
                    "Lütfen hesap oluşturmak istediğin mail adresini gir ve devam tuşuna bas.",
                size: 14,
                fontWeight: FontWeight.w500,
                color: "#1A1348",
              ),
              const SizedBox(height: 16),
              StreamBuilder<UserRole>(
                  stream: _checkBoxStream,
                  initialData: UserRole.STUDENT,
                  builder: (context, snapshot) {
                    userRole = snapshot.data!;
                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _checkBoxController.sink.add(UserRole.STUDENT);
                            userRole = UserRole.STUDENT;
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              // Border width
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: snapshot.data == UserRole.STUDENT
                                    ? HexColor("#FBD303")
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/student_circle.png"),
                                    const Center(
                                      child: YoHexText(
                                        text: "Öğrenci Üyeliği",
                                        size: 14,
                                        fontWeight: FontWeight.w700,
                                        color: "#1A1348",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            _checkBoxController.sink.add(UserRole.TEACHER);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              // Border width
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: snapshot.data == UserRole.TEACHER
                                    ? HexColor("#FBD303")
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/teacher_circle.png"),
                                    const Center(
                                      child: YoHexText(
                                        text: "Öğretmen Üyeliği",
                                        size: 14,
                                        fontWeight: FontWeight.w700,
                                        color: "#1A1348",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            _checkBoxController.sink.add(UserRole.COMPANY);
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              // Border width
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: snapshot.data == UserRole.COMPANY
                                    ? HexColor("#FBD303")
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/company_circle.png"),
                                    const Center(
                                      child: YoHexText(
                                        text: "Kurum Üyeliği",
                                        size: 14,
                                        fontWeight: FontWeight.w700,
                                        color: "#1A1348",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    );
                  }),
              const SizedBox(
                height: 16,
              ),
              const YoHexText(
                text:
                    "Lütfen hesap oluşturmak istediğin mail adresini gir ve devam tuşuna bas.",
                size: 14,
                fontWeight: FontWeight.w500,
                color: "#1A1348",
              ),
              const SizedBox(height: 50),
              TextBoxLabel(
                label: 'E-mail',
                hint: 'E-mailinizi girin',
                errorText: 'Bu alan zorunludur!',
                onSaved: (String value) {},
              ),
              const SizedBox(height: 32),
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/registerPage',
                          arguments: {'userRole': userRole});
                    },
                    child: const YoText(
                      text: "Devam Et",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
