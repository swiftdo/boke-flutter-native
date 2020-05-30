import 'package:flutter/material.dart';

const MaterialColor lightColor =
    MaterialColor(_lightColorPrimaryValue, <int, Color>{
  50: Color(0xFFFDEAE7),
  100: Color(0xFFFACBC3),
  200: Color(0xFFF7A89C),
  300: Color(0xFFF48574),
  400: Color(0xFFF16B56),
  500: Color(_lightColorPrimaryValue),
  600: Color(0xFFED4A32),
  700: Color(0xFFEB402B),
  800: Color(0xFFE83724),
  900: Color(0xFFE42717),
});

const int _lightColorPrimaryValue = 0xFFEF5138;

const MaterialColor lightColorAccent =
    MaterialColor(_lightColorAccentValue, <int, Color>{
  100: Color(0xFFFFFFFF),
  200: Color(_lightColorAccentValue),
  400: Color(0xFFFFB4AF),
  700: Color(0xFFFF9C96),
});
const int _lightColorAccentValue = 0xFFFFE4E2;
