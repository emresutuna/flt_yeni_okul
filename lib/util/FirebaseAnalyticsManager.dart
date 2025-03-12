import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsManager {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters}) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  static Future<void> logScreenView(String screenName) async {

    await _analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenName,
    );
  }
}


