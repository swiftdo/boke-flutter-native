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
      return MaterialPageRoute(
        builder: (context) {
          return MainPage();
        },
        settings: settings,
      );
    case LoginRoute:
      return CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) => LoginPage(),
        settings: settings,
      );
    case RegisterRoute:
      return MaterialPageRoute(
        builder: (context) {
          return RegisterPage();
        },
        settings: settings,
      );
    case ForgetPwdRoute:
      return MaterialPageRoute(
        builder: (context) {
          return ForgetPwdPage();
        },
        settings: settings,
      );
    case ProtocolRoute:
      return MaterialPageRoute(
        builder: (context) {
          return ProtocolPage();
        },
        settings: settings,
      );
    case ProfileRoute:
      return MaterialPageRoute(
        builder: (context) {
          return ProfilePage();
        },
        settings: settings,
      );
    case SettingRoute:
      return MaterialPageRoute(
        builder: (context) {
          return SettingPage();
        },
        settings: settings,
      );
    case TopicDetailRoute:
      return MaterialPageRoute(
        builder: (context) {
          Map args = ValueUtil.toMap(settings.arguments);
          return TopicDetailPage(
            topicId: ValueUtil.toStr(args['topicId']),
          );
        },
        settings: settings,
      );
    case BookletsRoute:
      return MaterialPageRoute(
        builder: (context) {
          return BookletsPage();
        },
        settings: settings,
      );

    case BookletRoute:
      return MaterialPageRoute(
        builder: (context) {
          Map args = ValueUtil.toMap(settings.arguments);
          return BookletPage(bookletId: ValueUtil.toStr(args['bookletId']));
        },
        settings: settings,
      );
    case BookletReadRoute:
      return MaterialPageRoute(
        builder: (context) {
          Map args = ValueUtil.toMap(settings.arguments);
          return BookletReadPage(catalog: args['catalog'], catalogs: args['catalogs']);
        },
        settings: settings,
      );
    case ThemeRoute:
      return MaterialPageRoute(
        builder: (context) {
          return ThemePage();
        },
        settings: settings,
      );
    case AboutMeRoute:
      return MaterialPageRoute(
        builder: (context) {
          return AboutMePage();
        },
        settings: settings,
      );
    case GamesRoute:
      return MaterialPageRoute(
        builder: (context) {
          return GamePage();
        },
        settings: settings,
      );
    case AnswerRoute:
      return MaterialPageRoute(
        builder: (context) {
          return AnswerPage();
        },
        settings: settings,
      );
    case WebViewRoute:
      Map args = ValueUtil.toMap(settings.arguments);
      return MaterialPageRoute(
        builder: (context) {
          return WebViewPage(
            title: args['title'],
            url: args['url'],
          );
        },
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Text('不支持 $routeName 路由'),
            ),
          );
        },
        settings: settings,
      );
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
