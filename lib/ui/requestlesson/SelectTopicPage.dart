import 'package:flutter/material.dart';

import '../../util/LessonExtension.dart';

class SelectTopicPage extends StatelessWidget {
  final List<BranchTopic> topics;

  const SelectTopicPage({required this.topics, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konu Seç")),
      body: ListView.separated(
        itemCount: topics.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topics[index].name, style: const TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context, topics[index]);
            },
          );
        },
      ),
    );
  }
}
