import 'package:flutter/material.dart';
import '../requestlesson/model/CourseRequestSchool.dart';

class SelectSchoolPage extends StatelessWidget {
  final List<CourseRequestSchool> schools;

  const SelectSchoolPage({required this.schools, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kurum Seç")),
      body: ListView.separated(
        itemCount: schools.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(schools[index].userName, style: const TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context, schools[index]);
            },
          );
        },
      ),
    );
  }
}
