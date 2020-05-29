import 'package:flutter/cupertino.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oktoast/oktoast.dart';
import 'package:oldbirds/locator.dart';
import 'package:oldbirds/macro.dart';
import 'package:oldbirds/services/services.dart';
import 'global_user_state.dart';

class MineRegisterState extends ViewStateModel {
  final GlobalUserState globalUserState;

  MineRegisterState({@required this.globalUserState}) {
    _agreeProtocol =
        SpUtil.getBool(Macro.saveKeyRemindAgreeProtocol, defValue: false);
  }

  final repository = locator<NativeRepository>();

  String _name;
  String get name => _name;

  String _email;
  String get email => _email;

  String _password;
  String get password => _password;

  String _againPwd;
  String get againPwd => _againPwd;

  bool _enableRegister = false;
  bool get enableRegister => _enableRegister;

  bool _agreeProtocol;
  bool get agreeProtocol => _agreeProtocol;

  bool get sending => viewState == ViewState.busy;

  void setName(String name) {
    _name = name;
    changeEnableRegister();
  }

  void setEmail(String email) {
    _email = email;
    changeEnableRegister();
  }

  void setPassword(String password) {
    _password = password;
    changeEnableRegister();
  }

  void setAgainPassword(String password) {
    _againPwd = password;
    changeEnableRegister();
  }

  void setAgreeProtocol(bool agree) {
    _agreeProtocol = agree;
    changeEnableRegister();
  }

  void changeEnableRegister() {
    if (_email != null &&
        _email.isNotEmpty &&
        _password != null &&
        _password.isNotEmpty &&
        _againPwd != null &&
        _againPwd.isNotEmpty &&
        _password == _againPwd &&
        _agreeProtocol) {
      _enableRegister = true;
    } else {
      _enableRegister = false;
    }
    notifyListeners();
  }

  /// 注册
  Future<ModelLogin> register({BuildContext context}) async {
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

    if (password != againPwd) {
      showToast("请确保两次密码输入一样");
      return null;
    }
    SpUtil.putBool(Macro.saveKeyRemindAgreeProtocol, true);
    setBusy();
    try {
      final _ =
          await repository.register(name: name, email: email, pwd: password);
      final result = await repository.login(pwd: password, email: email);
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
