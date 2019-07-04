import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Drawer(
          child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            height: 180,
            color: Theme.of(context).accentColor,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 40),
                  child: ClipOval(
                    child: Image.network(
                      "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1562115289&di=2097223e93c2bc5217cf2b79ca3fcd0e&src=http://pic.qjimage.com/ph115/high/ph3854-p03311.jpg",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "呆萌的小狗",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.camera),
            title: Text("收藏"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("设置"),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("关于"),
          )
        ],
      )),
    );
  }
}
