import 'package:flutter/material.dart';
import 'package:wanandroid/model/public_subscription_articles_model.dart';

class SubscriptionPage extends StatefulWidget {
  final String subscriptionId;

  const SubscriptionPage({Key key, this.subscriptionId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SubscriptionPageState();
  }
}

class SubscriptionPageState extends State<SubscriptionPage> {
  int _pageIndex = 0;
  List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Text(widget.subscriptionId);
  }
}
