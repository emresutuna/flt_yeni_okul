import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/YOColors.dart';

class SelectCourseTypePage extends StatelessWidget {
  final List<String> courseTypes = ["Ders", "Kurs"];

  SelectCourseTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ders/Kurs Seç"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        itemCount: courseTypes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              courseTypes[index],
              style: styleBlack14Bold,
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),
            onTap: () {
              Get.back(result: courseTypes[index]);
            },
          );
        },
      ),
    );
  }
}
