import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:oldbirds/locator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'routing/routing.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      dismissOtherOnShow: true,
      textPadding: EdgeInsets.all(20),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => GlobalUserState()),
          ChangeNotifierProvider(create: (ctx) => ThemeState())
        ],
        child: RefreshConfiguration(
            hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
            child: Consumer<ThemeState>(
              builder: (context, themeState, child) {
                if (themeState.darkMode == 2) {
                  return MaterialApp(
                    title: 'Oldbirds',
                    theme: themeState.lightTheme,
                    darkTheme: themeState.darkTheme,
                    onGenerateRoute: generateRoute,
                    initialRoute: SplashRoute,
                    debugShowCheckedModeBanner: false,
                  );
                } else {
                  return MaterialApp(
                    title: 'Oldbirds',
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
