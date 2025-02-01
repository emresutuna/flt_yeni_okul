import 'package:baykurs/util/YOColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GlobalWebViewPage extends StatefulWidget {
  final String url;
  final String pageTitle;

  const GlobalWebViewPage(
      {Key? key, required this.url, required this.pageTitle})
      : super(key: key);

  @override
  State<GlobalWebViewPage> createState() => _GlobalWebViewPageState();
}

void openWebView(String url, String pageTitle, {bool hasShowMenu = false}) {
  if (!hasShowMenu) {
    url = url.contains('?') ? '$url&ref=app' : '$url?ref=app';
  }

  Get.to(() => GlobalWebViewPage(
    url: url,
    pageTitle: pageTitle,
  ));
}


class _GlobalWebViewPageState extends State<GlobalWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        title: Text(
          widget.pageTitle,
          style: styleBlack14Bold,
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
