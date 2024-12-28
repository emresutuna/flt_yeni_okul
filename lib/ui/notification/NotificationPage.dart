import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationPage> {
  List<Map<String, String>> notifications = [
    {
      'title': 'Bildirim Başlık',
      'description':
          'Bildirim Açıklama lorem ipsum lorem ipsum Bildirim Açıklama lorem ipsum lorem ipsum',
      'date': '12.12.2024 14:43',
    },
    {
      'title': 'Bildirim Başlık',
      'description':
          'Bildirim Açıklama lorem ipsum lorem ipsum Bildirim Açıklama lorem ipsum lorem ipsum',
      'date': '12.12.2024 14:43',
    },
    {
      'title': 'Bildirim Başlık',
      'description':
          'Bildirim Açıklama lorem ipsum lorem ipsum Bildirim Açıklama lorem ipsum lorem ipsum',
      'date': '12.12.2024 14:43',
    },
  ];

  void removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar("Bildirimler", onTap: () {
        Navigator.pop(context);
      }),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hemen Kayıt olarak eşsiz deneyimimize katılabilirsin.',
              style: TextStyle(fontSize: 14),
            ),
            16.toHeight,
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return NotificationCard(
                    title: notification['title']!,
                    description: notification['description']!,
                    date: notification['date']!,
                    onDelete: () => removeNotification(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final VoidCallback onDelete;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: styleBlack16Bold,
              ),
            ],
          ),
          4.toHeight,
          Text(
            description,
            style: styleBlack14Regular,
          ),
          8.toHeight,
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              date,
              style: styleBlack12Regular.copyWith(color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}
