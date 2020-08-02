import 'package:loveli_core/loveli_core.dart';

import 'base.dart';

class LearnTop extends Base {
  String title;
  int type;
  String cover;
  String targetId;

  LearnTop.fromMap(Map json) : super.fromMap(json) {
    this.title = ValueUtil.toStr(json['title']);
    this.type = ValueUtil.toInt(json['type']);
    this.cover = ValueUtil.toStr(json['cover']);
    this.targetId = ValueUtil.toStr(json['targetId']);
  }
}
