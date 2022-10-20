import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebScreen extends StatefulWidget {
  const CommonWebScreen({Key? key, required this.title, required this.link})
      : super(key: key);

  final String title;
  final String link;

  @override
  State<CommonWebScreen> createState() => _CommonWebScreenState();
}

class _CommonWebScreenState extends State<CommonWebScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerDefaultWidget(
        title: widget.title,
        leading: FunctionalIcon.back,
        onClickLeading: () {
          Get.back();
        },
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        initialUrl: widget.link,
        gestureNavigationEnabled: true,
      ),
    );
  }
}
