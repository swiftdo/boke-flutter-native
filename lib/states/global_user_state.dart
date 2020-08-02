import 'package:flutter/cupertino.dart';
import 'package:loveli_core/loveli_core.dart';
import '../model/model.dart';
import 'package:oldbirds/macro.dart';
import 'package:oldbirds/services/services.dart';
import 'package:oldbirds/locator.dart';

class GlobalUserState extends ViewStateModel {
  User _user;
  Token _token;

  User get user => _user;
  Token get token => _token;

  final repository = locator<NativeRepository>();

  GlobalUserState() {
    _initData();
  }

  /// 初始化数据
  void _initData() async {
    await SpUtil.getInstance();
    _user = SpUtil.getObj(Macro.saveKeyUser, (json) {
      return json == null ? null : User.fromMap(json);
    });
    _token = SpUtil.getObj(Macro.saveKeyToken, (json) {
      return json == null ? null : Token.fromMap(json);
    });
    notifyListeners();
  }

  void login({@required User user, @required Token token}) {
    _user = user;
    _token = token;
    SpUtil.putObject(Macro.saveKeyUser, user.toMap());
    SpUtil.putObject(Macro.saveKeyToken, token.toMap());
    notifyListeners();
  }

  setUser(User user) {
    _user = user;
    SpUtil.putObject(Macro.saveKeyUser, user.toMap());
    notifyListeners();
  }

  setToken(Token token) {
    _token = token;
    SpUtil.putObject(Macro.saveKeyToken, token.toMap());
    notifyListeners();
  }

  void logout() {
    _user = null;
    _token = null;
    SpUtil.remove(Macro.saveKeyUser);
    SpUtil.remove(Macro.saveKeyToken);
    notifyListeners();
  }

  changeUserAvatar(String url) async {
    final User res =
        await repository.updateUser(avatar: url, token: token.accessToken);
    setUser(res);
  }

  Future<String> getQiNiuToken() async {
    return await repository.getQiNiuToken(token: token.accessToken);
  }

  bool get isLogin => user != null && token != null;
}
