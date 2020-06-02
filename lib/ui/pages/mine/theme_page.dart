import 'package:flutter/material.dart';
import 'package:oldbirds/themes/theme_state.dart';
import 'package:oldbirds/ui/ui.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Map items = ThemeState.darkModeMap;
            return ListView.builder(
              itemBuilder: (context, index) {
                return SettingListTitle(
                  onTap: () {
                    themeState.changeMode(items.keys.toList()[index]);
                  },
                  title: items.values.toList()[index],
                  trailing:
                      themeState.darkMode == index ? Icon(Icons.check) : null,
                );
              },
              itemCount: items.length,
            );
          },
        ));
  }
}
