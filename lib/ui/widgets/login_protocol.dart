import 'package:flutter/material.dart';

class LoginProtocol extends StatelessWidget {
  final bool isChecked;
  final GestureTapCallback onTap;

  const LoginProtocol({Key key, this.isChecked = false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Icon(
              isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: '我已阅读 OldBirds 的'),
                      TextSpan(text: '《用户服务协议》'),
                      TextSpan(text: '和'),
                      TextSpan(text: '《隐私政策》'),
                    ],
                    style: TextStyle(fontSize: 14, height: 1.4),
                  ),
                  maxLines: 2),
            ),
          ),
        ],
      ),
    );
  }
}
