import 'package:baykurs/ui/notification/bloc/NotificationBloc.dart';
import 'package:baykurs/ui/notification/bloc/NotificationEvent.dart';
import 'package:baykurs/ui/notification/bloc/NotificationState.dart';
import 'package:baykurs/ui/notification/model/NotificationResponse.dart';
import 'package:baykurs/util/all_extension.dart';
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
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        elevation: 10,
        title: Text("Filtrele", style: styleBlack16Bold),
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotificationBloc>().add(UpdateNotificationSeen());
            },
            child: Text(
              "Tümünü Gör",
              style: styleBlack14Bold.copyWith(
                color: color5,
                decoration: TextDecoration.underline,
                decorationColor: color5,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tüm bildirimlerini buradan takip edebilirsin.',
                style: styleBlack14Regular),
            16.toHeight,
            BlocListener<NotificationBloc, NotificationState>(
              listener: (BuildContext context, NotificationState state) {
                if (state is NotificationStateUpdated) {
                  context.read<NotificationBloc>().add(FetchNotifications());
                }
              },
              child: Expanded(
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
                            date: notification.formattedDate,
                            isSeen: notification.isSeen ?? false,
                          );
                        },
                      );
                    }

                    if (state is NotificationStateError) {
                      return _emptyState();
                    }

                    return _emptyState();
                  },
                ),
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
          Icon(Icons.notifications_off_outlined,
              size: 64, color: Colors.grey.shade400),
          12.toHeight,
          Text(
            'Bildirim bulunmuyor',
            style: styleBlack14Regular.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final bool isSeen;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.isSeen,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style:
                      styleBlack12Regular.copyWith(color: Colors.grey.shade600),
                ),
                const SizedBox(width: 8),
                SeenIndicator(isSeen: isSeen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SeenIndicator extends StatelessWidget {
  final bool isSeen;

  const SeenIndicator({Key? key, required this.isSeen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isSeen,
      child: Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(
          color: Colors.red[200],
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
