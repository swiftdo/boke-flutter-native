import 'dart:html';

import 'package:loveli_core/loveli_core.dart';

class User {
  String id;
  String name;
  String email;
  String avatar;

  User.fromMap(Map json) {
    if (json == null) {
      return;
    }
    id = ValueUtil.toStr(json['id']);
    name = ValueUtil.toStr(json['name']);
    email = ValueUtil.toStr(json['email']);
    avatar = ValueUtil.toStr(json['avatar']);
  }
}
