import 'package:flutter/material.dart';
import 'package:wanandroid/dao/public_subscription_dao.dart';
import 'package:wanandroid/model/public_subscription_model.dart';
import 'package:wanandroid/widget/subscription_page_widget.dart';

class PublicSubscriptionPage extends StatefulWidget {
  PublicSubscriptionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PublicSubscriptionState();
  }
}

class PublicSubscriptionState extends State<PublicSubscriptionPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<PublicSubscriptionPage> {
  TabController _tabController;

  List<Data> _tabData = [];
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
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              bottom: TabBar(
                tabs: _tabs,
                controller: _tabController,
                isScrollable: true,
              ),
            ),
            preferredSize: Size.fromHeight(50)),
        body: TabBarView(
          children: _tabData.map((item) {
            return SubscriptionPage(
              subscriptionId: item?.id,
            );
          }).toList(),
          controller: _tabController,
        ),
      );
    }
  }

  void _getSubscriptions() {
    _tabs?.clear();
    PublicSubscriptionDao.getSubscriptions().then((subscriptions) {
      _tabData = subscriptions?.data ?? [];
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

  @override
  bool get wantKeepAlive => true;
}
