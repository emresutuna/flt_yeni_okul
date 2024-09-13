import 'package:flutter/material.dart';

import '../../../util/YOColors.dart';
import '../../../widgets/PrimaryButton.dart';

class UserinfoEdit extends StatefulWidget {
  const UserinfoEdit({super.key});

  @override
  State<UserinfoEdit> createState() => _UserinfoEditState();
}

class _UserinfoEditState extends State<UserinfoEdit> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 0),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Text(
                  "Kullanıcı Bilgilerini Güncelle",
                  style: styleBlack16Bold,
                ),
                SizedBox(height: 8),
                Text(
                  "Kullanıcı Bilgilerini Güncelle",
                  style: styleBlack12Bold,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    cursorColor: color1,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      hintText: 'Mevcut Email',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: color2.withAlpha(75),
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle:
                          TextStyle(color: color1, fontWeight: FontWeight.bold),
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
                      hintText: 'Yeni Email ',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: color2.withAlpha(75),
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle:
                          TextStyle(color: color1, fontWeight: FontWeight.bold),
                      focusColor: color2,
                      focusedBorder: const UnderlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                PrimaryButton(text: "Güncelle", onPress: () => {}),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
