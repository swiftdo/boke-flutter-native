import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'light_color.dart';

class ThemeState with ChangeNotifier {
  /// 0：浅色模式  1：深色模式  2：跟随系统
  int _darkMode;
  int get darkMode => _darkMode;

  static const Map<int, String> darkModeMap = {0: '浅色模式', 1: '深色模式', 2: '跟随系统'};
  ThemeData get lightTheme =>
      ThemeData(brightness: Brightness.light, primarySwatch: lightColor);
  ThemeData get darkTheme => ThemeData.dark();

  ThemeState() {
    _init();
  }

  void _init() async {
    await SpUtil.getInstance();
    int localModel = SpUtil.getInt('kDarkMode', defValue: 2);
    changeMode(localModel);
  }

  void changeMode(int darkMode) async {
    _darkMode = darkMode;
    notifyListeners();
    SpUtil.putInt("kDarkMode", darkMode);
  }
}
