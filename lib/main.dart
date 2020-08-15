import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:oldbirds/locator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

import 'routing/routing.dart';
import 'services/ad/ad_manager.dart';
import 'states/states.dart';
import 'themes/theme_state.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  JPush jpush = JPush();

  @override
  void initState() {
    super.initState();
    _setupAd();
    _initJpush();
  }

  Future<void> _initJpush() async {
    try {
      //监听消息通知
      jpush.addEventHandler(
        // 接收通知回调方法。
        onReceiveNotification: (Map<String, dynamic> message) async {
          debugPrint("flutter onReceiveNotification: $message");
        },
        // 点击通知回调方法。
        onOpenNotification: (Map<String, dynamic> message) async {
          debugPrint("flutter onOpenNotification: $message");
        },
        // 接收自定义消息回调方法。
        onReceiveMessage: (Map<String, dynamic> message) async {
          debugPrint("flutter onReceiveMessage: $message");
        },
      );
    } catch (error) {
      debugPrint('平台版本获取失败，请检查！');
    }
    //初始化
    jpush.setup(
      appKey: "aaa5445d09e93ea32f97b9dd",
      channel: "flutter",
      production: false,
      debug: true, // 设置是否打印 debug 日志
    );

    jpush.applyPushAuthority(
        NotificationSettingsIOS(sound: true, alert: true, badge: true));
    //获取注册的id
    jpush.getRegistrationID().then((rid) {
      debugPrint("获取注册的id:$rid");
    });
  }

  void _setupAd() async {
    await FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      dismissOtherOnShow: true,
      textPadding: EdgeInsets.all(20),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => GlobalUserState(),
            lazy: false,
          ),
          ChangeNotifierProvider(
            create: (ctx) => ThemeState(),
            lazy: false,
          )
        ],
        child: RefreshConfiguration(
            hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
            child: Consumer<ThemeState>(
              builder: (context, themeState, child) {
                if (themeState.darkMode == 2) {
                  return MaterialApp(
                    theme: themeState.lightTheme,
                    darkTheme: themeState.darkTheme,
                    onGenerateRoute: generateRoute,
                    initialRoute: SplashRoute,
                    debugShowCheckedModeBanner: false,
                  );
                } else {
                  return MaterialApp(
                    theme: themeState.darkMode == 1
                        ? themeState.darkTheme
                        : themeState.lightTheme,
                    onGenerateRoute: generateRoute,
                    initialRoute: SplashRoute,
                    debugShowCheckedModeBanner: false,
                  );
                }
              },
            )),
      ),
    );
  }
}
