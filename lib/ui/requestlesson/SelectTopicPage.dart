import 'package:flutter/material.dart';

import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';

class SelectTopicPage extends StatelessWidget {
  final List<BranchTopic> topics;

  const SelectTopicPage({required this.topics, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konu Seç")),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics[index].name, style: styleBlack14Bold),
            trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),

            onTap: () {
              Navigator.pop(context, topics[index]);
            },
          );
        },
      ),
    );
  }
}
