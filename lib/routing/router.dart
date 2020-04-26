import 'package:flutter/material.dart';
import 'route_names.dart';
import '../ui/ui.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String routeName = settings.name;
  switch (routeName) {
    case MainRoute:
      return MaterialPageRoute(builder: (context) {
        return MainPage();
      });
    default:
      return MaterialPageRoute(builder: (context) {
        return Container(
          child: Center(
            child: Text('不支持 $routeName 路由'),
          ),
        );
      });
  }
}
