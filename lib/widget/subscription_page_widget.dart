import 'package:flutter/material.dart';
import 'package:wanandroid/dao/public_subscription_dao.dart';
import 'package:wanandroid/model/public_subscription_articles_model.dart';
import 'package:wanandroid/util/util.dart';

class SubscriptionPage extends StatefulWidget {
  final int subscriptionId;

  const SubscriptionPage({Key key, this.subscriptionId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SubscriptionPageState();
  }
}

class SubscriptionPageState extends State<SubscriptionPage> {
  int _pageIndex = 0;
  List<Article> _articles;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _articles = new List();
    _pageIndex = 0;
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMore);
    _fetchSubscriptionArticles();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _getArticleItem(index);
        },
        controller: _scrollController,
        itemCount: _articles?.length ?? 0,
      ),
    );
  }

  Widget _getArticleItem(int index) {
    if (_articles != null && _articles.length > 0) {
      Article item = _articles[index];
      return Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        padding: EdgeInsets.only(left: 10),
        margin: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 0),
        height: 50,
        child: GestureDetector(
          onTap: () {
            MyUtil.navigatorToWebView(context, item.link, item.title);
          },
          child: Text(item.title),
        ),
      );
    } else {
      return Container(
        height: 10,
        color: Colors.grey,
      );
    }
  }

  void _fetchSubscriptionArticles() {
    PublicSubscriptionDao.fetchSubscriptionArticles(
            widget.subscriptionId, _pageIndex)
        .then((response) {
      if (response != null && response.data != null) {
        setState(() {
          _articles.addAll(response.data.articles);
        });
      }
    }).catchError((e) {});
  }

  _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //加载更多
      print('滑动到了最底部${_scrollController.position.pixels}');
      _pageIndex++;
      _fetchSubscriptionArticles();
    }
  }

  Future<void> _refresh() async {
    _pageIndex = 0;
    _articles?.clear();
    _fetchSubscriptionArticles();
  }

  @override
  bool get wantKeepAlive => true;

}
