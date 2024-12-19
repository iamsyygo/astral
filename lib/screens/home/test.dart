import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

String html = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    p { text-align: center; }
    #btn { position: absolute; bottom: 50%; left: 50%; transform: translate(-50%, -50%); width: 300px; height: 100px; background: red; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <button id="btn" onclick="sendMessageToFlutter()">点击</button>
    </div>
    <script>
      function sendMessageToFlutter() {
        // 通过 ToFlutter channel 发送消息
        // ToFlutter.postMessage('来自JavaScript的消息');
        window.ToFlutter.postMessage('来自JavaScript的消息');
      }
    </script>
  </body>
  </html>
''';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      // ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'ToFlutter',
        onMessageReceived: (JavaScriptMessage message) {
          // 处理从 JavaScript 接收到的消息
          Get.snackbar('收到消息', message.message);
        },
      )
      // ..loadHtmlString(html);
      ..loadRequest(Uri.parse('http://127.0.0.1:8080'));
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressed,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _onPressed() {
    Get.snackbar("提示", "刷新页面");
  }
}
