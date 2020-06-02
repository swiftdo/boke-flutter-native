import 'package:flutter/material.dart';

class SettingListTitle extends StatelessWidget {
  final String title;
  final Widget trailing;
  final GestureTapCallback onTap;

  const SettingListTitle({Key key, this.trailing, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          title: Text(title),
          trailing: trailing,
        ),
        Divider(
          height: 0.5,
        )
      ],
    );
  }
}
