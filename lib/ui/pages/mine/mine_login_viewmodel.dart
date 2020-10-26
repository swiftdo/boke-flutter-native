import 'package:flutter/cupertino.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';
import 'package:oldbirds/locator.dart';
import 'package:oldbirds/macro.dart';
import 'package:oldbirds/services/services.dart';
import '../../../states/global_user_state.dart';

class MineLoginViewModel extends ViewStateModel {
  final GlobalUserState globalUserState;

  MineLoginViewModel({@required this.globalUserState}) {
    _agreeProtocol = SpUtil.getBool(Macro.saveKeyRemindAgreeProtocol, defValue: false);
  }

  final repository = locator<NativeRepository>();

  String _email;
  String get email => _email;

  String _password;
  String get password => _password;

  bool _enableLogin = false;
  bool get enableLogin => _enableLogin;

  bool _agreeProtocol;
  bool get agreeProtocol => _agreeProtocol;

  bool get sending => viewState == ViewState.busy;

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
    if (_email != null && _email.isNotEmpty && _password != null && _password.isNotEmpty && _agreeProtocol) {
      _enableLogin = true;
    } else {
      _enableLogin = false;
    }
    notifyListeners();
  }

  /// 登录
  Future<ModelLogin> login({BuildContext context}) async {
    if (sending) {
      return null;
    }
    if (!RegexUtil.isEmail(email)) {
      showToast("请输入正确的邮箱");
      return null;
    }
    if (password.length < 6) {
      showToast("请输入 6 位以上密码");
      return null;
    }
    SpUtil.putBool(Macro.saveKeyRemindAgreeProtocol, true);
    setBusy();
    try {
      final result = await repository.login(email: email, pwd: password);
      globalUserState.login(user: result.user, token: result.token);
      setIdle();
      return result;
    } catch (e, s) {
      setError(e, s);
      showErrorMessage(context, message: viewStateError.message);
      return null;
    }
  }
}
