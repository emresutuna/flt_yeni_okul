import 'package:flutter/material.dart';
import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';

class SelectBranchPage extends StatelessWidget {
  final List<Branches> branches;

  const SelectBranchPage({Key? key, required this.branches}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Branş Seç")),
      body: branches.isNotEmpty
          ? ListView.builder(
        itemCount: branches.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              branches[index].value, // Eğer `value` varsa onu da kullanabilirsin
              style: styleBlack14Bold,
            ),
            trailing:
            Icon(Icons.arrow_forward_ios, color: color5, size: 16),
            onTap: () {
              Navigator.pop(context, branches[index]);
            },
          );
        },
      )
          :  Center(
        child: Text(
          "Bu sınıfa uygun branş bulunmamaktadır.",
          style: styleBlack14Bold,
        ),
      ),
    );
  }
}
