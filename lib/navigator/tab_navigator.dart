import 'package:flutter/material.dart';
import 'package:wanandroid/pages/Knowledge_tree.dart';
import 'package:wanandroid/pages/home_page.dart';
import 'package:wanandroid/pages/public_subscriptions.dart';
import 'package:wanandroid/widget/my_drawer_wdiget.dart';

class MyNavigator extends StatefulWidget {
  static GlobalKey<NavigatorState> _globalKey = new GlobalKey();

  @override
  State<StatefulWidget> createState() {
//    _globalKey.currentState.appBarTitle
    return NavigatorState();
  }
}

class NavigatorState extends State<MyNavigator> {
  String appBarTitle = "首页";
  int _currentIndex = 0;

  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // AppBar - 顶部标题栏；PageView - 中间显示的Page页面；BottomNavigationBar - 底部导航栏

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: MyDrawer(),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          KnowledgeTreePage(),
          PublicSubscriptionPage()
        ],
        onPageChanged: (index) {
          setState(() {
            this._currentIndex = index;
            _setAppBarTitle();
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            // 点击跳转对应的PageView
            _pageController.jumpToPage(index);
            setState(() {
              this._currentIndex = index;
              _setAppBarTitle();
            });
          },
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("首页"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text("体系"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text("公众号"),
                backgroundColor: Colors.white)
          ]),
    );
  }

  void _setAppBarTitle() {
    if (_currentIndex == 0) {
      this.appBarTitle = "首页";
    } else if (_currentIndex == 1) {
      this.appBarTitle = "知识体系";
    } else {
      this.appBarTitle = "公众号";
    }
  }
}
