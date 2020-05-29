import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/locator.dart';
import 'routing/routing.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'states/states.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalUserState globalUserState = GlobalUserState();

  @override
  void initState() {
    super.initState();
    _setup();
  }

  _setup() async {
    await SpUtil.getInstance();
    globalUserState.initData();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      dismissOtherOnShow: true,
      textPadding: EdgeInsets.all(20),
      child: MultiProvider(
        providers: [ChangeNotifierProvider.value(value: globalUserState)],
        child: RefreshConfiguration(
          hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
          child: MaterialApp(
            title: 'Oldbirds',
            theme: ThemeData(primaryColor: Colors.white),
            darkTheme: ThemeData.dark(),
            onGenerateRoute: generateRoute,
            initialRoute: MainRoute,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
