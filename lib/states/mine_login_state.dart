import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';

class MineLoginState extends ViewStateModel {
  String _email;
  String get email => _email;

  String _password;
  String get password => _password;

  bool _enableLogin = false;
  bool get enableLogin => _enableLogin;

  bool _agreeProtocol = false;
  bool get agreeProtocol => _agreeProtocol;

  void setEmail(String email) {
    _email = email;
    changeEnableLogin();
  }

  void setPassword(String password) {
    _password = password;
    changeEnableLogin();
  }

  void setAgreeProtocol(bool agree) {
    _agreeProtocol = agree;
    changeEnableLogin();
  }

  void changeEnableLogin() {
    if (_email != null &&
        _email.isNotEmpty &&
        _password != null &&
        _password.isNotEmpty &&
        _agreeProtocol) {
      _enableLogin = true;
    } else {
      _enableLogin = false;
    }
    notifyListeners();
  }

  /// 登录
  void login() {
    if (!RegexUtil.isEmail(email)) {
      showToast("请输入正确的邮箱");
      return;
    }
    if (password.length < 6) {
      showToast("请输入 6 位以上密码");
      return;
    }
  }
}
