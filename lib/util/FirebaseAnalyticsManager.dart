import 'package:firebase_analytics/firebase_analytics.dart';


class FirebaseAnalyticsManager {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters}) async {
    print(" Firebase Event Gönderiliyor: $eventName, Parametreler: $parameters");

    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );

    print(" Firebase Event Gönderildi: $eventName");
  }

  static Future<void> logScreenView(String screenName) async {
    print(" Sayfa Görüntüleme Event Gönderiliyor: $screenName");

    await _analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenName,
    );

    print("Sayfa Görüntüleme Event Gönderildi: $screenName");
  }
}


