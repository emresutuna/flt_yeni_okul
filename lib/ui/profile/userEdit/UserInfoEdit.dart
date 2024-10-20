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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    children: [
                      InkWell(
                        child: const Icon(Icons.arrow_back_ios),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text("Email Güncelle", style: styleBlack16Bold),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Lorem ipsum dolar sit amet amet lorem ipsum dolar amet lorem ipsum amet dolar sit amet.',
                  style: styleBlack12Regular,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                            labelStyle: TextStyle(
                                color: color1, fontWeight: FontWeight.bold),
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
                            labelStyle: TextStyle(
                                color: color1, fontWeight: FontWeight.bold),
                            focusColor: color2,
                            focusedBorder: const UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const SizedBox(height: 32),
                      PrimaryButton(text: "Güncelle", onPress: () => {}),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
