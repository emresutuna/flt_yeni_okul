import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/SharedPrefHelper.dart';

class PaymentWebView extends StatefulWidget {
  final int courseId;

  const PaymentWebView({Key? key, required this.courseId}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController _controller;
  String? _token;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onWebResourceError: (WebResourceError error) {
              debugPrint("WebView Hata: ${error.description}");
            },
            onPageFinished: (String url) {
              debugPrint("Sayfa yüklendi: $url");
              _checkPaymentStatus(url);
            },
          ),
        );

      _loadTokenAndLoadWebView();
    });
  }

  Future<void> _loadTokenAndLoadWebView() async {
    final token = await getToken();
    if (token != null) {
      setState(() {
        _token = token;
      });

      _controller.loadRequest(
        Uri.parse("https://api.bykurs.com.tr/api/v1/mobile/payment?course_id=${widget.courseId}"),
        headers: {"Authorization": "Bearer $_token"},
      );
    }
  }

  void _checkPaymentStatus(String message) {
    if (message.contains("payment_ok")) {
      debugPrint("Gelen Mesaj: Success");

      _showResultDialog("Ödeme Başarılı", "Ödemeniz başarıyla tamamlandı.");
    } else if (message.contains("payment_fail")) {
      _showResultDialog("Ödeme Başarısız", "Ödemeniz tamamlanamadı, tekrar deneyin.");
    }
  }

  /// **Sonuç Göster**
  void _showResultDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (title == "Ödeme Başarılı") {
                Navigator.pop(context);
              }
            },
            child: Text("Tamam"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ödeme Sayfası")),
      body: _token == null
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller),
    );
  }
}
