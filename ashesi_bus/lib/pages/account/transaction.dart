// ignore_for_file: must_be_immutable

import 'package:ashesi_bus/helper/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Transaction extends StatelessWidget {

  Transaction(
    {
      super.key,
      required this.authorizationUrl
    }
  );

  String? authorizationUrl;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RegularAppBarNoBack(
        title: "Complete Transaction",
      ),
      body: WebView(
        initialUrl: authorizationUrl,
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: 'Flutter;Webview',
      ),
    );
  }
}