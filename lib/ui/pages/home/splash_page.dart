import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/routing/route_names.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _info = '';

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
      _info = "引导页～";
    });
  }

  /// App广告页逻辑。
  void _initSplash() {
    setState(() {
      _info = "广告页，2秒后跳转到主页";
    });
    Future.delayed(new Duration(milliseconds: 2000), () {
      Navigator.of(context).pushReplacementNamed(MainRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
      ),
      body: new Center(
        child: new Text("$_info"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool isGuide = SpUtil.getBool("key_guide", defValue: true);
          if (isGuide) {
            Navigator.of(context).pushReplacementNamed(MainRoute);
          }
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
