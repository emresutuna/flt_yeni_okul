import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/YOColors.dart';
import '../course/model/course_type_enum.dart';

class SelectCourseTypePage extends StatelessWidget {
  final List<CourseTypeEnum> courseTypes = [
    CourseTypeEnum.course,
    CourseTypeEnum.courseBundle,
  ];

  SelectCourseTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ders/Kurs Seç"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        itemCount: courseTypes.length,
        itemBuilder: (context, index) {
          final type = courseTypes[index];

          return ListTile(
            title: Text(
              type.label,
              style: styleBlack14Bold,
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),
            onTap: () {
              Get.back(result: type);
            },
          );
        },
      ),
    );
  }
}
