import 'package:flutter/material.dart';
import 'package:wanandroid/dao/public_subscription_dao.dart';
import 'package:wanandroid/widget/subscription_page_widget.dart';

class PublicSubscriptionPage extends StatefulWidget {
  PublicSubscriptionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PublicSubscriptionState();
  }
}

class PublicSubscriptionState extends State<PublicSubscriptionPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Tab> _tabs = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 14, vsync: this);
    _getSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabs.length <= 0) {
      return null;
    } else {
      return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: _tabs,
            controller: _tabController,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: _tabs.map((item) {
//            SubscriptionPage(item.)
          }).toList(),
          controller: _tabController,
        ),
      );
    }
  }

  void _getSubscriptions() {
    PublicSubscriptionDao.getSubscriptions().then((subscriptions) {
      setState(() {
        subscriptions?.data?.forEach((item) {
          _tabs.add(new Tab(text: item.name));
        });
      });
    }).catchError((e) {});
  }

  @override
  void dispose() {
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
    }
  }
}
