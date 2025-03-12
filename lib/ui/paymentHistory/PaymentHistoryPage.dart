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
  String selectedFilter = "Ders";

  final List<Map<String, dynamic>> purchaseHistory = [
    {
      "title": "Matematik Özel Dersi",
      "schoolName": "ABC Eğitim Kurumu",
      "teacherName": "Ahmet Yılmaz",
      "startDate": "12 Mart 2025",
      "endDate": "12:00",
      "price": "₺350",
      "serviceType": "Ders",
      "backgroundColor": Colors.blue,
    },
    {
      "title": "Kodlama Kursu",
      "schoolName": "XYZ Akademi",
      "teacherName": "Mehmet Can",
      "startDate": "20 Mart 2025",
      "endDate": "15:00",
      "price": "₺500",
      "serviceType": "Kurs",
      "backgroundColor": Colors.green,
    },
    {
      "title": "Eğitim Koçluğu",
      "schoolName": "Başarı Akademi",
      "teacherName": "Elif Yıldız",
      "startDate": "25 Mart 2025",
      "endDate": "17:00",
      "price": "₺600",
      "serviceType": "Eğitim Koçu",
      "backgroundColor": Colors.orange,
    },
  ];

  final List<String> filterOptions = ["Ders", "Kurs", "Eğitim Koçu"];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = purchaseHistory
        .where((item) => item["serviceType"] == selectedFilter)
        .toList();

    return Scaffold(
      appBar: WhiteAppBar("Satın Alma Geçmişi"),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filterOptions.length,
                itemBuilder: (context, index) {
                  String filter = filterOptions[index];
                  bool isSelected = selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? color5 : Colors.white,
                          border: Border.all(color: color5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left:24.0,right: 24,),
                            child: Text(
                              filter,
                              style: styleBlack14Bold.copyWith(color: isSelected ? Colors.white :color5,)
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // **Filtrelenmiş Liste**
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  var item = filteredList[index];
                  return PurchaseHistoryItem(
                    title: item["title"],
                    schoolName: item["schoolName"],
                    teacherName: item["teacherName"],
                    startDate: item["startDate"],
                    endDate: item["endDate"],
                    price: item["price"],
                    serviceType: item["serviceType"],
                    backgroundColor: item["backgroundColor"],
                  );
                },
              ),
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
  final String serviceType;
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
                        text: "Öğretmen: ",
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
