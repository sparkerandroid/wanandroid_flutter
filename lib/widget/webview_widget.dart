import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyWebView extends StatefulWidget {
  final String url;
  final String title;
  final bool withZoom;
  final bool withLocalStorage;
  final bool hidden;
  final Widget initChild;

  MyWebView(
      {Key key,
      this.url,
      this.title,
      this.withZoom,
      this.withLocalStorage,
      this.hidden,
      this.initChild})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyWebViewState();
  }
}

class MyWebViewState extends State<MyWebView> {

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      withZoom: widget.withZoom,
      withLocalStorage: widget.withLocalStorage,
      hidden: widget.hidden,
      initialChild: widget.initChild,
    );
  }
}
