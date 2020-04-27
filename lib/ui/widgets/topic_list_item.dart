import 'package:flutter/material.dart';
import '../../model/model.dart';

class TopicListItem extends StatelessWidget {
  final Topic item;
  final int index;
  final GestureTapCallback onTap;

  TopicListItem({this.item, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(20),
      height: 100,
    );
  }
}
