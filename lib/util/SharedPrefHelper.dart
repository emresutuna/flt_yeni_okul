import 'dart:convert';
import 'dart:ffi';

import 'package:baykurs/ui/notification/model/NotificationResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../ui/dashboard/model/MobileHomeResponse.dart';


Future<void> saveToken(String? token) async {
  if (token != null && token.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}

Future<void> saveNotification(Notifications notificationModel) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonData = jsonEncode(notificationModel.toJson());
  await prefs.setString('notification', jsonData);
}
Future<Notifications?> getNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? jsonData = prefs.getString('notification');

  if (jsonData != null) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonData);
    return Notifications.fromJson(jsonMap);
  }

  return null;
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}
Future<bool?> getIsFirstTime() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstTime');
}
Future<void> saveIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
}

Future<void> saveData(String? data, String name) async {
  if (data != null && data.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(name, data);
  }
}

Future<String?> readData(String name) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(name);
}

Future<void> clearSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
void refreshApp() {
  Get.offAllNamed('/mainPage');
}