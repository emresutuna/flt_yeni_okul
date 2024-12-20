import 'package:flutter/material.dart';

import '../../util/LessonExtension.dart';
import '../../util/YOColors.dart';
import '../../widgets/WhiteAppBar.dart';

class FilterTopicPage extends StatefulWidget {
  final List<BranchTopic> topics;
  final int? initialTopicId;

  const FilterTopicPage({
    super.key,
    required this.topics,
    this.initialTopicId,
  });

  @override
  State<FilterTopicPage> createState() => _FilterTopicPageState();
}

class _FilterTopicPageState extends State<FilterTopicPage> {
  BranchTopic? selectedTopic;

  @override
  void initState() {
    super.initState();
    selectedTopic = widget.topics.cast<BranchTopic?>().firstWhere(
        (topic) => topic?.id == widget.initialTopicId,
        orElse: () => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar(
        "Konu Seç",
        onTap: () {
          Navigator.pop(
            context,
            selectedTopic != null
                ? {"id": selectedTopic!.id, "name": selectedTopic!.name}
                : null,
          );
        },
      ),
      body: widget.topics.isEmpty
          ? const Center(
              child: Text(
                "Bu branşa ait ders bulunmamaktadır.",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: widget.topics.length,
                    itemBuilder: (context, index) {
                      final topic = widget.topics[index];
                      return ListTile(
                        title: Text(topic.name),
                        trailing: selectedTopic?.id == topic.id
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                        onTap: () {
                          setState(() {
                            selectedTopic = topic;
                          });
                        },
                      );
                    },
                  ),
                ),
                _buildFilterButton(() {
                  Navigator.pop(
                    context,
                    selectedTopic != null
                        ? {"id": selectedTopic!.id, "name": selectedTopic!.name}
                        : null,
                  );
                }),
              ],
            ),
    );
  }

  Widget _buildFilterButton(VoidCallback callback) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: color5,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
        child: Text(
          "Tamam",
          style: styleWhite14Bold,
        ),
      ),
    );
  }
}
