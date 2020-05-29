import 'package:flutter/material.dart';
import 'package:loveli_core/provider/provider_widget.dart';
import 'package:oldbirds/routing/route_names.dart';
import 'package:oldbirds/states/mine_register_state.dart';
import 'package:provider/provider.dart';
import '../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ProviderWidget<MineRegisterState>(
        builder: (context, state, child) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                child,
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                  child: ProgressButton(
                    onPressed: () {
                      if (state.enableRegister) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        state.register(context: context).then((result) {
                          if (result != null) {
                            Navigator.of(context)..pop()..pop();
                          }
                        });
                      }
                    },
                    buttonState: state.sending
                        ? ButtonState.inProgress
                        : ButtonState.normal,
                    backgroundColor: state.enableRegister
                        ? Color(0xff333333)
                        : Color(0xffCACACA),
                    progressColor: Colors.white,
                    child: Text(
                      '注册',
                      style: TextStyle(
                          color: state.enableRegister
                              ? Colors.white
                              : Color(0xff999999),
                          fontSize: 16),
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
          );
        },
        model: MineRegisterState(globalUserState: Provider.of(context)),
        child: Builder(builder: (context) => _buildForm(context)),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    MineRegisterState state =
        Provider.of<MineRegisterState>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 16),
          child: Text(
            '注册',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: TextField(
            onChanged: (text) => state.setName(text),
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333333), width: 1)),
                labelText: '昵称',
                hintText: '请输入你的昵称',
                labelStyle: TextStyle(color: Colors.grey)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: TextField(
            onChanged: (text) => state.setEmail(text),
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333333), width: 1)),
                labelText: '邮箱',
                hintText: '请输入邮箱',
                labelStyle: TextStyle(color: Colors.grey)),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: TextField(
            onChanged: (text) => state.setPassword(text),
            obscureText: true,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333333), width: 1)),
                labelText: '密码',
                hintText: '请输入密码',
                labelStyle: TextStyle(color: Colors.grey)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12),
          child: TextField(
            onChanged: (text) => state.setAgainPassword(text),
            obscureText: true,
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff333333), width: 1)),
                labelText: '确认密码',
                hintText: '请再次输入密码',
                labelStyle: TextStyle(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
