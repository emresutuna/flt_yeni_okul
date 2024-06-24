import 'package:flutter/material.dart';
import 'package:yeni_okul/util/HexColor.dart';
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
    return GradientContainer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    YoText(
                      text: "Profile",
                      size: 18,
                    ),
                  ],
                ),
              ),
              YOCardView(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 16),
                        height: 100,
                        width: 100,
                        // Border width
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(48),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48), // Image radius
                            child: Image.asset("assets/ic_user.png",
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Center(
                          child: YoText(
                        text: "Martin Nel",
                        size: 20,
                      )),
                    ),
                    Center(
                      child: YoCircleItem(
                        text: "08",
                        asset: null,
                        circleColor: HexColor("#ebecff"),
                        textColor: HexColor("#9ba1ff"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: YoText(
                          text: "Kursa Başlandı",
                          fontWeight: FontWeight.w500,
                          size: 14,
                        ),
                      ),
                    ),
                    Center(
                      child: YoCircleItem(
                        text: "08",
                        asset: null,
                        circleColor: HexColor("#dbf3e9"),
                        textColor: HexColor("#4dc591"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: YoText(
                          text: "Kurs Tamamlandı",
                          fontWeight: FontWeight.w500,
                          size: 14,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24.0, left: 8),
                      child: YoText(
                        text: "Yardım Merkezi",
                        fontWeight: FontWeight.w600,
                        size: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0,top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          profileCircleWithTitle("Mentor Ol", Icons.person,HexColor("#def4fe")),
                          profileCircleWithTitle("Yardım", Icons.support_agent_outlined,HexColor("#dbf3e9")),
                          profileCircleWithTitle("Arkadaşlarını Davet Et", Icons.people,HexColor("#ebecff")),
                          profileCircleWithTitle("Hesabını Sil", Icons.delete_forever,HexColor("#ffdfe4")),
                          const SizedBox(height: 24,)
                        ],
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
  Widget profileCircleWithTitle(String title, IconData icons,HexColor bgColor) => Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
          margin: const EdgeInsets.only(top: 16),
          alignment: Alignment.center,
          height: 48,
          width: 48,
          // Border width
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
          ),
          child:  Icon(icons)),
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
