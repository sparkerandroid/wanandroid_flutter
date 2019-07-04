import 'package:flutter/material.dart';
import 'package:wanandroid/widget/webview_widget.dart';

class MyUtil {
  static void navigatorToWebView(
      BuildContext context, String url, String title) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MyWebView(
        url: url,
        title: title,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initChild: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }));
  }
}
