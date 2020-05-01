import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oldbirds/routing/route_names.dart';

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
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  MineListTitle(title: '我的消息', icon: Icons.notifications),
                  MineListTitle(title: '意见反馈', icon: Icons.feedback),
                  MineListTitle(
                    title: '设置',
                    icon: Icons.settings,
                    showLine: false,
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
  MineListTitle({this.title, this.icon, this.showLine = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Color(0xfff4f4f4),
          ),
        ),
        showLine
            ? Divider(
                color: Color(0xfff4f4f4),
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
      color: Colors.white,
      padding: EdgeInsets.all(16),
      height: 100,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).pushNamed(LoginRoute);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: SvgPicture.asset(
                'assets/images/mine_user_not_login.svg',
                width: 80,
                height: 80,
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
                      '登录',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '登录以使用更多功能',
                      style: TextStyle(fontSize: 12, color: Color(0xffADADAD)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
