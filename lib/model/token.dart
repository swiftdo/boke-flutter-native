import 'package:loveli_core/loveli_core.dart';

class Token {
  String accessToken;
  double expiresAt;
  String refreshToken;

  Token.fromMap(Map json) {
    accessToken = ValueUtil.toStr(json['accessToken']);
    expiresAt = ValueUtil.toDouble(json['expiresAt']);
    refreshToken = ValueUtil.toStr(json['refreshToken']);
  }
}
