import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/PriceFormatter.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';

import '../../util/HexColor.dart';
import '../../util/YOColors.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Satın Alma Geçmişi"),
      body: const SafeArea(
        child: Column(
          children: [
            PurchaseHistoryItem(
              title: "Matematik Özel Dersi",
              schoolName: "ABC Eğitim Kurumu",
              teacherName: "Ahmet Yılmaz",
              startDate: "12 Mart 2025",
              endDate: "12:00",
              price: "₺350",
              serviceType: "Ders",
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseHistoryItem extends StatelessWidget {
  final String title;
  final String schoolName;
  final String teacherName;
  final String startDate;
  final String? endDate;
  final String price;
  final String serviceType; // Ders, Kurs, Eğitim Koçu
  final Color backgroundColor;

  const PurchaseHistoryItem({
    super.key,
    required this.title,
    required this.schoolName,
    required this.teacherName,
    required this.startDate,
    this.endDate,
    required this.price,
    required this.serviceType,
    required this.backgroundColor,
  });

  void _showOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: Text(
                "Detayları Gör",
                style: styleBlack14Bold,
              ),
              onTap: () {
                Navigator.pop(context);
                // Detayları açma işlemi buraya eklenebilir
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: Text(
                "Faturayı İndir",
                style: styleBlack14Bold,
              ),
              onTap: () {
                Navigator.pop(context);
                // Fatura indirme işlemi buraya eklenebilir
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: Text(
                "Kaydı Sil",
                style: styleBlack14Bold,
              ),
              onTap: () {
                Navigator.pop(context);
                // Silme işlemi buraya eklenebilir
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: HexColor("#F7F9F9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.5,
            color: HexColor("#222831").withAlpha(60),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst kısım: Başlık + Menü Butonu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(title, style: styleBlack14Bold),
                ),
                InkWell(
                  onTap: () => _showOptionsBottomSheet(context),
                  child: const Icon(Icons.more_vert),
                ),

              ],
            ),
            const SizedBox(height: 8),

            // Kurum Bilgisi
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Kurum: ",
                    style: styleBlack12Regular,
                  ),
                  TextSpan(
                    text: schoolName,
                    style: styleBlack12Bold,
                  ),
                ],
              ),
            ),
            6.toHeight,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Hizmet: ",
                    style: styleBlack12Regular,
                  ),
                  TextSpan(
                    text: serviceType,
                    style: styleBlack12Bold,
                  ),
                ],
              ),
            ),

            if (teacherName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Eğitmen: ",
                        style: styleBlack12Regular,
                      ),
                      TextSpan(
                        text: teacherName,
                        style: styleBlack12Bold,
                      ),
                    ],
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Tarih: ",
                      style: styleBlack12Regular,
                    ),
                    TextSpan(
                      text: "$startDate - ${endDate ?? '-'}",
                      style: styleBlack12Bold,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Text(formatPrice(price), style: styleGreen18Bold,),
            ),
          ],
        ),
      ),
    );
  }
}
