import 'package:flutter/material.dart';
import 'routing/routing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oldbirds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: MainRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
