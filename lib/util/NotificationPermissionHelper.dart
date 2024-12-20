import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPermissionHelper {
  static final NotificationPermissionHelper _instance =
  NotificationPermissionHelper._internal();

  // Firebase Messaging instance
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Private constructor
  NotificationPermissionHelper._internal();

  // Singleton instance getter
  static NotificationPermissionHelper get instance => _instance;

  /// Request notification permissions
  Future<bool> requestPermission(BuildContext context) async {
    NotificationSettings settings =
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
      return true;
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User granted provisional permission");
      return true;
    } else {
      print("User declined or has not accepted permission");
      _showPermissionDialog(context);
      return false;
    }
  }

  /// Check current notification permission status
  Future<bool> checkPermission() async {
    NotificationSettings settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// Show a dialog if permission is denied
  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Bildirim İzni Gerekli",style: styleBlack16Bold,),
          content: Text(
              "Bildirimler için izin vermeniz gerekiyor. Ayarlar sayfasından izin verebilirsiniz.",style: styleBlack14Bold,),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam",style: styleBlack14Bold,),
            ),
          ],
        );
      },
    );
  }
}
