import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';

class SelectClassPage extends StatelessWidget {
  SelectClassPage({Key? key}) : super(key: key);

  final List<ClassTypes> classLevels = ClassTypes.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sınıf Seç"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView.builder(
        itemCount: classLevels.length,
        itemBuilder: (context, index) {
          final classType = classLevels[index];
          return ListTile(
            title: Text(
              classType.value,
              style: styleBlack14Bold,
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),
            onTap: () {
              Get.back(result: classType);
            },
          );
        },
      ),
    );
  }
}
