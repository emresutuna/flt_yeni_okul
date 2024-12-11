import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMMethods {
  static void initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.getToken().then((value) => debugPrint('fcm token $value'));

    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      } else if (settings.authorizationStatus !=
          AuthorizationStatus.provisional) {
      }
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
    });
  }
}

