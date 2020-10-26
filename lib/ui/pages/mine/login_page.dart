import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/routing/routing.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';
import 'mine_login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      model: MineLoginViewModel(globalUserState: Provider.of(context)),
      builder: (context, MineLoginViewModel state, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                child,
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: ProgressButton(
                    onPressed: () {
                      if (state.enableLogin) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        state.login(context: context).then((result) {
                          if (result != null) {
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                    buttonState: state.sending ? ButtonState.inProgress : ButtonState.normal,
                    backgroundColor: state.enableLogin ? Color(0xFFEF5138) : Theme.of(context).disabledColor,
                    progressColor: Colors.white,
                    child: Text(
                      '登录',
                      style: TextStyle(color: state.enableLogin ? Colors.white : Colors.white70, fontSize: 16),
                    ),
                  ),
                ),
                LoginProtocol(
                  isChecked: state.agreeProtocol,
                  onTap: () {
                    state.setAgreeProtocol(!state.agreeProtocol);
                  },
                )
              ],
            ),
          ),
        );
      },
      child: Builder(builder: (context) => _buildForm(context)),
    );
  }

  Widget _buildForm(BuildContext context) {
    MineLoginViewModel state = Provider.of<MineLoginViewModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        LoginHeader(),
        LoginWelcomeTitle(),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 20),
          child: TextField(
            onChanged: (text) => state.setEmail(text),
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
              labelText: '邮箱',
              hintText: '请输入邮箱',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: TextField(
            obscureText: true,
            onChanged: (text) => state.setPassword(text),
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1)),
                labelText: '密码',
                hintText: '请输入密码'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ForgetPwdRoute);
          },
          child: Container(
            padding: EdgeInsets.only(right: 16, top: 15, bottom: 15),
            child: Text('忘记密码'),
            alignment: Alignment.centerRight,
          ),
        )
      ],
    );
  }
}

class LoginWelcomeTitle extends StatelessWidget {
  const LoginWelcomeTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 30),
      child: Text(
        '你好\n欢迎来到 OldBirds',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.4),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: MediaQuery.of(context).padding.top),
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                size: 36,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RegisterRoute);
              },
              child: Text(
                '注册',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
