import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oldbirds/routing/route_names.dart';

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
                      TextSpan(
                          text: '《用户服务协议》',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(WebViewRoute, arguments: {
                                'title': '用户服务协议',
                                'url':
                                    'https://oldbird.run/about/app/t1-protocol.html',
                              });
                            }),
                      TextSpan(text: '和'),
                      TextSpan(
                          text: '《隐私政策》',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushNamed(WebViewRoute,
                                  arguments: {
                                    'title': '隐私政策',
                                    'url':
                                        'https://oldbird.run/about/app/t2-secrect.html'
                                  });
                            }),
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
