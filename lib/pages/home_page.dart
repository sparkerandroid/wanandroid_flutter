import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wanandroid/dao/home_dao.dart';
import 'package:wanandroid/model/home_articles_model.dart';
import 'package:wanandroid/model/home_banner_model.dart';
import 'package:wanandroid/util/util.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

// 默认不会保持页面状态的，需使用AutomaticKeepAliveClientMixin
class HomeState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  List<HomeBannerModel> _homeBannerData;
  List<HomeArticle> _homeArticleData;

  int curBannerIndex = 0;
  int pageIndex = 0;

  ScrollController scrollController;

  bool showFloatingButton;

  @override
  void initState() {
    super.initState();

    scrollController = new ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 200) {
        setState(() {
          showFloatingButton = true;
        });
      }
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //加载更多
        print('滑动到了最底部${scrollController.position.pixels}');
        setState(() {
          pageIndex++;
          _fetchArticleData();
        });
      }
    });

    _homeBannerData = new List();
    _homeArticleData = new List();

    _fetchBannerData();
    _fetchArticleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            scrollController.jumpTo(0);
          },
          child: Icon(Icons.arrow_upward),
        ),
        body: RefreshIndicator(
          child: ListView(
            children: <Widget>[swiper, articles],
            controller: scrollController,
          ),
          onRefresh:
              _onRefresh, //下拉回调方法,方法需要有async和await关键字，没有await，刷新图标立马消失，没有async，刷新图标不会消失
        ));
  }

  @override
  void dispose() {
    super.dispose();
    scrollController?.dispose();
  }

  Future<void> _onRefresh() async {
    _fetchBannerData();

    pageIndex = 0;
    _homeArticleData?.clear();
    _fetchArticleData();
    return;
  }

  void _fetchBannerData() {
    HomeDao.fetchHomeBanner().then((banner) {
      setState(() {
        _homeBannerData?.clear();
        _homeBannerData?.addAll(banner?.banners);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  void _fetchArticleData() {
    HomeDao.fetchHomeArticles(pageIndex).then((article) {
      setState(() {
        _homeArticleData?.addAll(article?.articles);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Widget get swiper {
    return Container(
      height: 200,
      child: Swiper(
        autoplay: true,
        index: curBannerIndex,
        onIndexChanged: (index) {
          curBannerIndex = index;
        },
        itemBuilder: (BuildContext context, int index) {
          return _getSwiperItem(context, index);
        },
        itemCount: _homeBannerData?.length ?? 0,
        pagination: new SwiperPagination(),
      ),
    );
  }

  Widget _getSwiperItem(BuildContext context, int index) {
    if (_homeBannerData != null) {
      var banner = _homeBannerData[index];
      if (banner == null) {
        return null;
      } else {
        return GestureDetector(
          onTap: () {
            MyUtil.navigatorToWebView(context, banner.url, banner.title);
          },
          child: Image.network(banner.imagePath, fit: BoxFit.fill),
        );
      }
    } else {
      return null;
    }
  }

  Widget get articles {
    List<Widget> articles = new List();
    if (_homeArticleData != null && _homeArticleData.length > 0) {
      _homeArticleData.forEach((item) {
        articles.add(Container(
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
        ));
      });
    }
    if (articles.length > 0) {
      return Column(
        children: articles,
      );
    } else {
      return Center(
        heightFactor: 1,
        child: Text("努力加载中......"),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
