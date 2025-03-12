import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var isFirstTime = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
  }

  Future<void> checkUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTime.value = prefs.getBool('isFirstTime') ?? true;
    String userToken = prefs.getString('auth_token') ?? "";
    isLoggedIn.value = userToken.isNotEmpty;
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    isFirstTime.value = false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    isLoggedIn.value = false;
    Get.offAllNamed('/mainPage');
  }
}
