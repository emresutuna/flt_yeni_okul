import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPermissionHelper {
  static final NotificationPermissionHelper instance =
      NotificationPermissionHelper._internal();

  factory NotificationPermissionHelper() {
    return instance;
  }

  NotificationPermissionHelper._internal();

  Future<void> requestNotificationPermission(BuildContext context) async {
    var status = await Permission.notification.status;

    if (!status.isGranted) {
      status = await Permission.notification.request();
    }

    if (status.isDenied) {
      debugPrint('Bildirim izni reddedildi.');
    } else if (status.isPermanentlyDenied) {
      debugPrint('Bildirim izni kalıcı olarak reddedildi.');

      if (Platform.isAndroid) {
        openAppSettings();
      } else if (Platform.isIOS) {
        // iOS için kullanıcıya ayarlara gitmesi gerektiğini bildiren dialog
        if (Localizations.of<MaterialLocalizations>(
                context, MaterialLocalizations) !=
            null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Bildirim İzni Gerekli'),
              content: const Text(
                'Bildirimleri alabilmek için Ayarlar > Bildirimler üzerinden uygulamaya izin vermelisiniz.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tamam'),
                ),
              ],
            ),
          );
        } else {
          debugPrint('MaterialLocalizations bulunamadı. Dialog gösterilemedi.');
        }
      }
    } else {
      debugPrint('Bildirim izni verildi.');
    }
  }

  Future<void> initializeFCM() async {
    try {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      final token = await FirebaseMessaging.instance.getToken();
      debugPrint('Firebase Messaging Token: $token');
    } catch (e) {
      debugPrint('FCM Token alınamadı: $e');
    }
  }

  Future<void> handleNotificationPermissions(BuildContext context) async {
    await requestNotificationPermission(context);
    await initializeFCM();
  }
}
