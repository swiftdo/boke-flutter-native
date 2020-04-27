import 'package:flutter/material.dart';
import 'routing/routing.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
      child: MaterialApp(
        title: 'Oldbirds',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        onGenerateRoute: generateRoute,
        initialRoute: MainRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
