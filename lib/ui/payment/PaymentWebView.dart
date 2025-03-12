import 'package:baykurs/service/api_urls.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/SharedPrefHelper.dart';
import 'PaymentResultPage.dart';

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
        Uri.parse(
            "${ApiUrls.mainUrl}/mobile/payment?course_id=${widget.courseId}"),
        headers: {"Authorization": "Bearer $_token"},
      );
    }
  }

  void _checkPaymentStatus(String message) {
    if (message.contains("payment_ok")) {
      _navigateToPaymentResult(context, true);
    } else if (message.contains("payment_fail")) {
      _navigateToPaymentResult(context, false);
    }
  }

  void _navigateToPaymentResult(BuildContext context, bool isSuccess) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentResultPage(isSuccess: isSuccess),
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
