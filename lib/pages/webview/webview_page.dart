import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:wanandroid/controller/webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetView<WebController> {
  WebViewPage({Key? key}) : super(key: key) {
    Get.lazyPut(() => WebController());
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> arguments = Get.arguments;
    controller.title.value = arguments["title"] ?? "";
    controller.url.value = arguments["url"] ?? "";
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text("${controller.title}"),
          ),
          body: WebView(
            initialUrl: "${controller.url}",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webController) {},
            onProgress: (int progress) {},
            onPageFinished: (url) {},
          ),
        ));
  }
}
