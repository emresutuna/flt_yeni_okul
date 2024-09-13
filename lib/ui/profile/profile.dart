import 'package:flutter/material.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'package:yeni_okul/widgets/GradientContainer.dart';
import 'package:yeni_okul/widgets/YOCardView.dart';
import 'package:yeni_okul/widgets/YOCircleItem.dart';
import 'package:yeni_okul/widgets/YOText.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1.2,
                width: MediaQuery.of(context).size.width,
                color: color5,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, top: 16, bottom: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profil",
                        style: styleWhite16Bold,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(child: Text("EŞ")),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Emre Şutuna",
                                  style: styleWhite14Regular,
                                ),
                                Text(
                                  "+90 534 507 6159",
                                  style: styleWhite14Regular,
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1.2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        profileItem("Ders Geçmişim", onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/timeSheetPage");
                        }),
                        profileItem("Ders Programı", onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed("/timeSheetPage");
                        }),
                        profileItem("Kullanıcı Bilgileri", onTap: () {}),
                        profileItem("Eğitim Bilgileri", onTap: () {}),
                        profileItem("Favorilerim", onTap: () {}),
                        profileItem("SSS", onTap: () {}),
                        profileItem("Yardım Merkezi", onTap: () {}),
                        profileItem("Hesabımı Sil", onTap: () {}),
                        profileItem("Çıkış Yap",
                            onTap: () {}, color: color6, isLastItem: true),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileItem(String title,
      {Color color = const Color(0xFF222831),
      bool isLastItem = false,
      VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          top: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: styleBlack14Bold.copyWith(color: color),
                ),
                isLastItem
                    ? const SizedBox.shrink()
                    : const Icon(Icons.chevron_right)
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            isLastItem
                ? const SizedBox.shrink()
                : Divider(
                    height: 1,
                    color: color.withAlpha(50),
                  ),
          ],
        ),
      ),
    );
  }

  Widget profileCircleWithTitle(
          String title, IconData icons, HexColor bgColor) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 16),
              alignment: Alignment.center,
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
              ),
              child: Icon(icons)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16),
            child: YoText(
              text: title,
              fontWeight: FontWeight.w600,
              size: 12,
            ),
          ),
        ],
      );
}
