import 'package:flutter/material.dart';
import 'package:yeni_okul/util/YOColors.dart';

import '../../util/HexColor.dart';
import '../../widgets/InfoWidget.dart';

class CourseDetailPage extends StatefulWidget {
  const CourseDetailPage({super.key});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, top: 8),
                      child: Row(
                        children: [
                          InkWell(
                            child: const Icon(Icons.arrow_back_ios),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            "Ders Detayı",
                            style: styleBlack16Bold
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 24,bottom: 16),
                      child: Text(
                        "Lorem ipsum dolar sit amet",
                        style: styleBlack12Bold,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const InfoCardWidget(
                      title: 'Bilgi',
                      description:
                      'Bir bölgedeki tüm kurumlardan ya da tek bir kurumdan ders talebinde bulunarak, kurumların bir sonraki haftanın ders programına talep ettiğin dersi eklemelerini sağlayabilirsin.',
                      icon: Icons.info_outline,
                    ),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: HexColor("F9F9F9"),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Course Title and Price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    'YKS HAZIRLIK – MATEMATİK – Fonksiyon 8 – Karma Soru Çözümleriyle Genel Tekrar',
                                    style: styleBlack14Bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Course Information (Date, Time, and Location)
                          Row(
                            children: [
                              Text(
                                '25/05/2024 | Saat: 10:00 - 11:30',
                                style: styleBlack12Regular,
                              ),
                              const Spacer(),
                              Text('250₺',
                                  style: styleBlack16Bold.copyWith(
                                      color: greenButton)),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.room,
                                  size: 16, color: Colors.grey),
                              Text(' G-105', style: styleBlack12Regular),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Lesson Badge and Description
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Matematik',
                                  style: styleWhite12Bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Divider(
                            height: 1,
                            color: Colors.black38.withAlpha(40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ders Açıklaması',
                            style: styleBlack14Bold,
                          ),
                          const SizedBox(height: 8),

                          Text(
                            'Lorem ipsum dolar sit amet amet lorem ipsum dolar amet lorem ipsum amet dolar sit amet.',
                            style: styleBlack12Regular,
                          ),
                          const SizedBox(height: 12),
                          const SizedBox(height: 8),
                          Divider(
                            height: 1,
                            color: Colors.black38.withAlpha(40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Öğretmen Bilgisi',
                            style: styleBlack14Bold,
                          ),
                          const SizedBox(height: 8),

                          Text('Mehmet Can Nokay - Matematik',
                              style: styleBlack12Regular),
                          const SizedBox(height: 8),
                          Divider(
                            height: 1,
                            color: Colors.black38.withAlpha(40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Kurum Bilgisi',
                            style: styleBlack14Bold,
                          ),
                          const SizedBox(height: 8),

                          Text('İstanbul Fatih Sınav KURS',
                              style: styleBlack12Bold),
                          Text('Fatih Mahallesi No:20 Fatih/İstanbul',
                              style: styleBlack12Regular),
                          const SizedBox(height: 16),
                          // Placeholder for the map image
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                                child: Icon(Icons.map,
                                    size: 50, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100,)
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 60,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Satın alma işlemi burada gerçekleşecek
                  },
                  child: Text(
                    "Satın Al",
                    style: styleWhite16Bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
