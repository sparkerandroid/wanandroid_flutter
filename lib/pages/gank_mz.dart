import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wanandroid/dao/gank_mz_dao.dart';
import 'package:wanandroid/model/gank_mz_model.dart';

class GankMzPage extends StatefulWidget {
  GankMzPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GankMzPageState();
  }
}

class GankMzPageState extends State<GankMzPage>
    with AutomaticKeepAliveClientMixin<GankMzPage> {
  List<MzItem> _data = [];
  int _pageIndex = 1;
  ScrollController _scrollController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    _scrollController.addListener(_loadMore);
    _fetchGankData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) =>
            new Image.network(_data[index]?.url, fit: BoxFit.cover),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        controller: _scrollController,
      ),
      onRefresh: _refresh,
    );
  }

  _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      //加载更多
      setState(() {
        isLoading = true;
      });
      print('滑动到了最底部${_scrollController.position.pixels}');
      _pageIndex++;
      _fetchGankData();
    }
  }

  Future<void> _refresh() async {
    _pageIndex = 0;
    _data.clear();
    _fetchGankData();
  }

  void _fetchGankData() {
    GankDao.fetchGankMzPics(_pageIndex).then((response) {
      setState(() {
        isLoading = false;
        _data.addAll(response?.results);
      });
    }).catchError((e) {});
  }

  @override
  bool get wantKeepAlive => true;
}
