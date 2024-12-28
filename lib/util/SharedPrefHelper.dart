import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';


Future<void> saveToken(String? token) async {
  if (token != null && token.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
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