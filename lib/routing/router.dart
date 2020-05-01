import 'package:flutter/cupertino.dart';
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
    case LoginRoute:
      return CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => LoginPage());
    case RegisterRoute:
      return MaterialPageRoute(builder: (context) {
        return RegisterPage();
      });
    case ForgetPwdRoute:
      return MaterialPageRoute(builder: (context) {
        return ForgetPwdPage();
      });
    case ProtocolRoute:
      return MaterialPageRoute(builder: (context) {
        return ProtocolPage();
      });
    case ProfileRoute:
      return MaterialPageRoute(builder: (context) {
        return ProfilePage();
      });
    default:
      return MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Center(
            child: Text('不支持 $routeName 路由'),
          ),
        );
      });
  }
}
