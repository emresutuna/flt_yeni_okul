import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPermissionHelper {
  static final NotificationPermissionHelper instance = NotificationPermissionHelper._internal();

  factory NotificationPermissionHelper() {
    return instance;
  }

  NotificationPermissionHelper._internal();

  Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;

    if (!status.isGranted) {
      status = await Permission.notification.request();
    }

    if (status.isDenied) {
      debugPrint('Bildirim izni reddedildi.');
    } else if (status.isPermanentlyDenied) {
      debugPrint('Bildirim izni kalıcı olarak reddedildi.');
      openAppSettings();
    } else {
      debugPrint('Bildirim izni verildi.');
    }
  }

  Future<void> initializeFCM() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint('Firebase Messaging Token: $token');
  }

  /// Tüm bildirim izinlerini yönet
  Future<void> handleNotificationPermissions() async {
    await requestNotificationPermission();
    await initializeFCM();
  }
}
