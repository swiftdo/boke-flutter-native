import 'package:loveli_core/loveli_core.dart';

import 'base.dart';

class LearnTool extends Base {
  String title;
  int type;
  String icon;

  LearnTool.fromMap(Map json) : super.fromMap(json) {
    this.title = ValueUtil.toStr(json['title']);
    this.type = ValueUtil.toInt(json['type']);
    this.icon = ValueUtil.toStr(json['icon']);
  }
}
