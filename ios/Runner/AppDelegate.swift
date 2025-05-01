import UIKit
import Flutter
import GoogleMaps
import Firebase
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Firebase başlatma
    FirebaseApp.configure()
    
    // Google Maps API Key
    GMSServices.provideAPIKey("AIzaSyCJKCPfYyUDTsIARB1x0677mddnQGdYfFc")

    // Bildirim yetkilendirme (iOS 10+ için delegate ayarı)
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
