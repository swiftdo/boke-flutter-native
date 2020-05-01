import 'package:flutter/material.dart';

class ForgetPwdPage extends StatefulWidget {
  @override
  _ForgetPwdPageState createState() => _ForgetPwdPageState();
}

class _ForgetPwdPageState extends State<ForgetPwdPage> {
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
                '忘记密码',
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
                    labelText: '新密码',
                    hintText: '请输入新密码',
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
                    labelText: '确认新密码',
                    hintText: '请再次输入新密码',
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
                  '提交',
                  style: TextStyle(color: Color(0xff999999), fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
