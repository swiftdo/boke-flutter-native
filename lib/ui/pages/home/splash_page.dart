import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/routing/route_names.dart';

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
    PageViewModel(
        pageColor: Color(0xFFEF5138),
        mainImage: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset('assets/images/home.png'),
        ),
        title: Text(
          'OldBirds',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 34.0,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text(
            '为程序员每日发现优质内容，每个频道内都有一到多个为你精心准备的优质内容源。',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        iconColor: Colors.white,
        iconImageAssetPath: 'assets/images/hi.png'),
    PageViewModel(
        pageColor: Color(0xFFEF5138),
        mainImage: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset('assets/images/learn.png'),
        ),
        title: Text(
          '学习',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 34.0,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Text('学习不但意味着接受新知识，同时还要修正错误乃至对错误的认识',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
        ),
        iconColor: Colors.white,
        iconImageAssetPath: 'assets/images/knowledge.png'),
    PageViewModel(
      pageColor: Color(0xFFEF5138),
      mainImage: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Image.asset('assets/images/like.png'),
      ),
      title: Text(
        '兴趣',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 34.0,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Text('任何一种兴趣都包含着天性中有倾向性的呼声，也许还包含着一种处在原始状态中的天才的闪光',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
      ),
      iconImageAssetPath: 'assets/images/love.png',
      iconColor: Colors.white,
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
      _type = SplashPageType.animate;
    });
    Future.delayed(Duration(seconds: 3), () {
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
      return IntroViewsFlutter(
        pageList,
        doneText: Text('完成', style: TextStyle(fontSize: 16, color: Colors.white)),
        onTapDoneButton: () {
          Navigator.of(context).pushReplacementNamed(MainRoute);
        },
        onTapSkipButton: () {
          Navigator.of(context).pushReplacementNamed(MainRoute);
        },
        showSkipButton: true,
        skipText: Text(
          '跳过',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    } else if (_type == SplashPageType.animate) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width,
          child: TypewriterAnimatedTextKit(
              totalRepeatCount: 1,
              text: ["OldBirds", "Be Better!", "Hello World!"],
              textStyle: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
        ),
      );
    } else {
      return Container();
    }
  }
}
