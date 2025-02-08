import 'package:flutter/material.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';

class SelectBranchPage extends StatelessWidget {
  final List<Branches> branches = Branches.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Branş Seç")),
      body: ListView.separated(
        itemCount: branches.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(branches[index].value, style: const TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context, branches[index]);
            },
          );
        },
      ),
    );
  }
}
