import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oldbirds/states/global_user_state.dart';
import 'package:provider/provider.dart';
import 'package:oldbirds/routing/route_names.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人中心'), centerTitle: false, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MineHeader(),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  MineListTitle(title: '我的消息', icon: Icons.notifications),
                  MineListTitle(title: '意见反馈', icon: Icons.feedback),
                  MineListTitle(
                    title: '主题配置',
                    icon: Icons.color_lens,
                    onTap: () {
                      Navigator.of(context).pushNamed(ThemeRoute);
                    },
                  ),
                  MineListTitle(
                    title: '设置',
                    icon: Icons.settings,
                    showLine: false,
                    onTap: () {
                      Navigator.of(context).pushNamed(SettingRoute);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MineListTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool showLine;
  final GestureTapCallback onTap;
  MineListTitle({this.title, this.icon, this.onTap, this.showLine = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ),
        showLine
            ? Divider(
                height: 0.5,
              )
            : Container()
      ],
    );
  }
}

class MineHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 100,
      child: Consumer<GlobalUserState>(
        builder: (context, state, child) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (state.isLogin) {
                Navigator.of(context).pushNamed(ProfileRoute);
              } else {
                Navigator.of(context).pushNamed(LoginRoute);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: state.isLogin
                      ? CachedNetworkImage(
                          imageUrl: state.user.avatar,
                          placeholder: (context, str) {
                            return SvgPicture.asset(
                              'assets/images/mine_user_not_login.svg',
                              width: 80,
                              height: 80,
                              color: Theme.of(context).primaryColor,
                            );
                          },
                        )
                      : SvgPicture.asset(
                          'assets/images/mine_user_not_login.svg',
                          width: 80,
                          height: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          state.isLogin ? state.user.name : '登录',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          state.isLogin ? '查看和编辑个人资料' : '登录以使用更多功能',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffADADAD)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
