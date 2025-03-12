import 'package:flutter/material.dart';

import 'BaseDeeplinkHandler.dart';

class AppDeeplinkHandler extends BaseDeeplinkHandler {
  final BuildContext context;

  AppDeeplinkHandler(this.context);

  @override
  void handleDeepLink(Uri uri) {

    // Örnek: Ürün sayfasına yönlendirme
    /*
    if (uri.path == '/product') {
      String productId = uri.queryParameters['id'] ?? '0';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(productId: productId),
        ),
      );
    }

     */

    // Diğer deeplink işlemleri buraya eklenebilir
  }
}