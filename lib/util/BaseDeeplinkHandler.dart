import 'package:uni_links/uni_links.dart';
import 'dart:async';

abstract class BaseDeeplinkHandler {
  StreamSubscription? _sub;

  // Deeplink dinlemeyi başlat
  void startListening() {
    _initUniLinks();
  }

  // Deeplink dinlemeyi durdur
  void stopListening() {
    _sub?.cancel();
  }

  // Deeplink işleme metodu (alt sınıflar tarafından implemente edilecek)
  void handleDeepLink(Uri uri);

  // UniLinks başlatma ve dinleme
  Future<void> _initUniLinks() async {
    // Uygulama zaten açıkken gelen deeplinkleri dinle
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    }, onError: (err) {
      // Hata durumunda işlemler
      print("Deeplink error: $err");
    });

    // Uygulama kapalıyken gelen deeplinkleri yakala
    try {
      Uri? initialUri = await getInitialUri();
      if (initialUri != null) {
        handleDeepLink(initialUri);
      }
    } catch (e) {
      // Hata durumunda işlemler
      print("Initial deeplink error: $e");
    }
  }
}