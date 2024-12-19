import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  final Uri? initialUrl;
  final String? html;
  final String? title;

  const WebView({
    super.key,
    this.title,
    this.initialUrl,
    this.html,
  });

  @override
  State<WebView> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    if (widget.initialUrl != null) {
      _controller.loadRequest(widget.initialUrl!);
    } else {
      _controller.loadHtmlString(widget.html ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title ?? '',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        body: WebViewWidget(
          controller: _controller,
        ));
  }
}
