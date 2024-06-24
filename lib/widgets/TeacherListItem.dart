import 'package:flutter/material.dart';
import 'package:yeni_okul/widgets/YOText.dart';

class TeacherListItem extends StatelessWidget {
  final String teacherName;
  final String teacherBranch;

  const TeacherListItem(
      {super.key, required this.teacherName, required this.teacherBranch});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: YoText(
        text: teacherName,
        fontWeight: FontWeight.w500,
        size: 10,
      ),
      subtitle: YoText(
        text: teacherBranch,
        size: 10,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
