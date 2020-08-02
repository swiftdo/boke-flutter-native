import 'package:loveli_core/loveli_core.dart';
import 'booklet.dart';
import 'learn_tool.dart';
import 'learn_top.dart';

import 'base.dart';

class Learn extends Base {
  List<LearnTool> tools;
  List<LearnTop> tops;
  List<Booklet> booklets;

  Learn.fromMap(Map json) : super.fromMap(json) {
    this.tools = ValueUtil.toList(json['tools'])
        .map((e) => LearnTool.fromMap(e))
        .toList();

    this.tops =
        ValueUtil.toList(json['tops']).map((e) => LearnTop.fromMap(e)).toList();

    this.booklets = ValueUtil.toList(json['booklets'])
        .map((e) => Booklet.fromMap(e))
        .toList();
  }
}
