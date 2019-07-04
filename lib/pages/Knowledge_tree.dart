import 'package:flutter/material.dart';

class KnowledgeTreePage extends StatefulWidget {
  KnowledgeTreePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return KnowledgeTreeState();
  }
}

class KnowledgeTreeState extends State<KnowledgeTreePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[Text("知识体系")],
      ),
    );
  }
}
