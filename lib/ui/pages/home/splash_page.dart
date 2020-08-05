import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/routing/route_names.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

enum SplashPageType {
  guide, // 引导
  ad, // 广告
  animate, // 开屏动画
  none,
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashPageType _type = SplashPageType.none;

  final pageList = [
    PageModel(
        color: const Color(0xFF678FB4),
        heroAssetPath: 'assets/images/home.png',
        title: Text(
          '首页',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 34.0,
          ),
        ),
        body: Text('为程序员每日发现优质内容，每个频道内都有一到多个为你精心准备的优质内容源。',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/images/news.png'),
    PageModel(
        color: const Color(0xFF65B0B4),
        heroAssetPath: 'assets/images/learn.png',
        title: Text('学习',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('学习不但意味着接受新知识，同时还要修正错误乃至对错误的认识',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconAssetPath: 'assets/images/knowledge.png'),
    PageModel(
      color: const Color(0xFF9B90BC),
      heroAssetPath: 'assets/images/like.png',
      title: Text('兴趣',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('任何一种兴趣都包含着天性中有倾向性的呼声，也许还包含着一种处在原始状态中的天才的闪光',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
      iconAssetPath: 'assets/images/love.png',
    )
  ];

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  _initAsync() async {
    await SpUtil.getInstance();

    /// 是否显示引导页
    if (SpUtil.getBool("key_guide", defValue: true)) {
      SpUtil.putBool("key_guide", false);
      _initBanner();
    } else {
      _initSplash();
    }
  }

  /// App引导页逻辑。
  void _initBanner() {
    setState(() {
      _type = SplashPageType.guide;
    });
  }

  /// App广告页逻辑。
  void _initSplash() {
    setState(() {
      _type = SplashPageType.ad;
    });
    Future.delayed(new Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed(MainRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_type == SplashPageType.guide) {
      return FancyOnBoarding(
        doneButtonText: "完成",
        skipButtonText: "跳过",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed(MainRoute),
        onSkipButtonPressed: () =>
            Navigator.of(context).pushReplacementNamed(MainRoute),
      );
    } else {
      return Container();
    }
  }
}
