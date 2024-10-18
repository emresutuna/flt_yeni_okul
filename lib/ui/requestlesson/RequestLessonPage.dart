import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../util/YOColors.dart';
import '../../widgets/InfoWidget.dart';
import '../../widgets/PrimaryButton.dart';
class RequestLessonPage extends StatelessWidget {
  final TextEditingController lessonController = TextEditingController();

  RequestLessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell( onTap: (){
          Navigator.pop(context);
        },
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          'Ders Talep Et',
          style: styleBlack16Bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Açıklama metinleri
              Text(
                'İhtiyacın olan dersi talep ederek sonraki haftanın programına dahil edebilirsin.',
                style: GoogleFonts.notoSans(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const InfoCardWidget(
                title: 'Bilgi',
                description:
                'Bir bölgedeki tüm kurumlardan ya da tek bir kurumdan ders talebinde bulunarak, kurumların bir sonraki haftanın ders programına talep ettiğin dersi eklemelerini sağlayabilirsin.',
                icon: Icons.info_outline,
              ),
              const SizedBox(height: 16),
              // Ders Seçim TextField
              TextField(
                controller: lessonController,
                cursorColor: color1,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText: 'Ders Seç',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: color2.withAlpha(75),
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Konu Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                ),
                items: <String>['Konu 1', 'Konu 2', 'Konu 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
                hint: const Text('Konu Seç'),
              ),
              const SizedBox(height: 16),
              // Bölge Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                ),
                items: <String>['Bölge 1', 'Bölge 2', 'Bölge 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
                hint: const Text('Bölge Seç'),
              ),
              const SizedBox(height: 16),
              // Saat Aralığı Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: color1),
                  ),
                ),
                items: <String>['Saat 1', 'Saat 2', 'Saat 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
                hint: const Text('Saat Aralığı Seç'),
              ),
              const SizedBox(height: 24),
              // Talep Et Butonu
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: "Ders Talep Et",
                  onPress: () {
                    // Butona tıklandığında yapılacak işlemler
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
