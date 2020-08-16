import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'route_names.dart';
import '../ui/ui.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  String routeName = settings.name;
  switch (routeName) {
    case SplashRoute:
      return NoAnimRouteBuilder(SplashPage());
    case MainRoute:
      return MaterialPageRoute(builder: (context) {
        return MainPage();
      });
    case LoginRoute:
      return CupertinoPageRoute(fullscreenDialog: true, builder: (context) => LoginPage());
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
    case SettingRoute:
      return MaterialPageRoute(builder: (context) {
        return SettingPage();
      });
    case TopicDetailRoute:
      return MaterialPageRoute(builder: (context) {
        Map args = ValueUtil.toMap(settings.arguments);
        return TopicDetailPage(
          topicId: ValueUtil.toStr(args['topicId']),
        );
      });
    case BookletsRoute:
      return MaterialPageRoute(builder: (context) {
        return BookletsPage();
      });

    case BookletRoute:
      return MaterialPageRoute(builder: (context) {
        Map args = ValueUtil.toMap(settings.arguments);
        return BookletPage(bookletId: ValueUtil.toStr(args['bookletId']));
      });
    case BookletReadRoute:
      return MaterialPageRoute(builder: (context) {
        Map args = ValueUtil.toMap(settings.arguments);
        return BookletReadPage(catalog: args['catalog'], catalogs: args['catalogs']);
      });
    case ThemeRoute:
      return MaterialPageRoute(builder: (context) {
        return ThemePage();
      });
    case AboutMeRoute:
      return MaterialPageRoute(builder: (context) {
        return AboutMePage();
      });
    case GamesRoute:
      return MaterialPageRoute(builder: (context) {
        return GamePage();
      });
    case AnswerRoute:
      return MaterialPageRoute(builder: (context) {
        return AnswerPage();
      });
    case WebViewRoute:
      Map args = ValueUtil.toMap(settings.arguments);
      return MaterialPageRoute(builder: (context) {
        return WebViewPage(
          title: args['title'],
          url: args['url'],
        );
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

class NoAnimRouteBuilder extends PageRouteBuilder {
  final Widget page;
  NoAnimRouteBuilder(this.page)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionDuration: Duration(milliseconds: 0),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => child);
}
