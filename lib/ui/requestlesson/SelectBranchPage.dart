import 'package:flutter/material.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';

class SelectBranchPage extends StatelessWidget {
  final List<Branches> branches = Branches.values;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Branş Seç")),
      body: ListView.builder(
        itemCount: branches.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              branches[index].value,
              style: styleBlack14Bold,
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),

            onTap: () {
              Navigator.pop(context, branches[index]);
            },
          );
        },
      ),
    );
  }
}
