import 'package:flutter/material.dart';
import 'package:oldbirds/themes/theme_state.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  final items = ['浅色模式', '深色模式', '跟随系统'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text('主题选择'),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Consumer<ThemeState>(
          builder: (context, themeState, child) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    themeState.changeMode(index);
                  },
                  title: Text(
                    items[index],
                    style: TextStyle(
                        color: index == themeState.darkMode
                            ? Colors.red
                            : Color(0xff333333)),
                  ),
                );
              },
              itemCount: items.length,
            );
          },
        ));
  }
}
