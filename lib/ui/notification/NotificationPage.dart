import 'package:baykurs/ui/notification/bloc/NotificationBloc.dart';
import 'package:baykurs/ui/notification/bloc/NotificationEvent.dart';
import 'package:baykurs/ui/notification/bloc/NotificationState.dart';
import 'package:baykurs/ui/notification/model/NotificationResponse.dart';
import 'package:baykurs/util/AllExtension.dart';
import 'package:baykurs/util/GlobalLoading.dart';
import 'package:baykurs/util/ListExtension.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/YOColors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationBloc>().add(FetchNotifications());
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
              'Tüm bildirimlerini buradan takip edebilirsin.',
              style: TextStyle(fontSize: 14),
            ),
            16.toHeight,
            Expanded(
              child: BlocConsumer<NotificationBloc, NotificationState>(
                listener: (context, state) {
                  if (state is NotificationStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Bir hata oluştu: ${state.error}'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is NotificationStateLoading) {
                    return const GlobalFadeAnimation();
                  }

                  if (state is NotificationStateSuccess) {
                    final notifications = state.notificationResponse.data;

                    if (notifications.isNullOrEmpty) {
                      return _emptyState();
                    }

                    return ListView.builder(
                      itemCount: notifications?.length,
                      itemBuilder: (context, index) {
                        final notification = notifications![index];

                        return NotificationCard(
                          title: notification.title ?? '',
                          description: notification.description ?? '',
                          date: notification.formattedDate, // Formatlanmış tarih
                          onDelete: () => _removeNotification(index, notifications!),
                        );
                      },
                    );
                  }

                  if (state is NotificationStateError) {
                    return _emptyState(); // Hata durumunda empty state gösteriliyor
                  }

                  return _emptyState(); // Default fallback
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey.shade400),
          12.toHeight,
          Text(
            'Bildirim bulunmuyor',
            style: styleBlack14Regular.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  void _removeNotification(int index, List notifications) {
    final currentState = context.read<NotificationBloc>().state;

    if (currentState is NotificationStateSuccess) {
      final updatedList = List.from(currentState.notificationResponse.data!);
      updatedList.removeAt(index);

      context.read<NotificationBloc>().emit(NotificationStateSuccess(updatedList as NotificationResponse));
    }
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
              Expanded(
                child: Text(
                  title,
                  style: styleBlack16Bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: onDelete,
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
