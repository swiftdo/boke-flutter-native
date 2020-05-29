import 'package:flutter/material.dart';
import 'package:oldbirds/states/states.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalUserState>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text('设置'),
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
                SettingListTitle(
                  title: '清除缓存',
                  onTap: () {},
                  trailing: Text(
                    '7.79',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SettingListTitle(
                  title: '关于 OldBirds',
                ),
                state.isLogin
                    ? Container(
                        margin: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            state.logout();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xffEF543C),
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 80),
                            child: Text(
                              '退出登录',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingListTitle extends StatelessWidget {
  final String title;
  final Widget trailing;
  final GestureTapCallback onTap;

  const SettingListTitle({Key key, this.trailing, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          title: Text(title),
          trailing: trailing,
        ),
        Divider(
          color: Color(0xfff4f4f4),
        )
      ],
    );
  }
}
