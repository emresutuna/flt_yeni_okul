import 'package:flutter/material.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/util/YOColors.dart';
import 'package:yeni_okul/widgets/TertiaryButton.dart';

class CourseListItem extends StatelessWidget {
  const CourseListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 0.5,
              color: HexColor("#80333333"),
            )),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 12,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "YKS HAZIRLIK – MATEMATİK – Fonksiyon 8 – Karma Soru Çözümleriyle Genel Tekrar",
                        style: styleBlack14Bold,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "İstanbul Fatih Sınav KURS",
                          style: styleBlack12Bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Tarih : 25/05/2024 | Saat: 10:00 - 11:30",
                          style: styleBlack12Regular,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "350₺",
                              style: styleGreen18Bold,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                            ),
                            TertiaryButton(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 40,
                                borderRadius: 8,
                                text: "Satın Al",
                                textColor: null,
                                onPress: () {})
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                    height: double.maxFinite,
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [Color(0xFFFF3A44), Color(0xFFFF7F85)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                    ),
                    child: Center(
                      child: RotatedBox(
                          quarterTurns: 3,
                          child: Text(
                            "Matematik",
                            style: styleWhite12Bold,
                          )),
                    )))
          ],
        ),
      ),
    );
  }
}
