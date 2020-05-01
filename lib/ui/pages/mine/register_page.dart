import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Column(
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
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff333333), width: 1)),
                    labelText: '昵称',
                    hintText: '请输入你的昵称',
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 12),
              child: TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff333333), width: 1)),
                    labelText: '邮箱',
                    hintText: '请输入邮箱',
                    labelStyle: TextStyle(color: Colors.grey)),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 12),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff333333), width: 1)),
                    labelText: '密码',
                    hintText: '请输入密码',
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 12),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xff333333), width: 1)),
                    labelText: '确认密码',
                    hintText: '请再次输入密码',
                    labelStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    color: Color(0xffCACACA),
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 12, bottom: 12),
                margin: EdgeInsets.only(left: 16, right: 16, top: 20),
                child: Text(
                  '登录',
                  style: TextStyle(color: Color(0xff999999), fontSize: 16),
                )),
            LoginProtocol()
          ],
        ),
      ),
    );
  }
}
