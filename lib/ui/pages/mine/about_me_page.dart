import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  String _appName;
  String _info;

  @override
  void initState() {
    super.initState();
    getPackageInfo();
  }

  void getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appName = packageInfo.appName;
    _info = '${packageInfo.version}(${packageInfo.buildNumber})';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('关于 Oldbirds'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/ic_launch.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Container(
              child: Text(
                _appName ?? 'OldBirds',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              margin: EdgeInsets.only(top: 10),
            ),
            if (_info != null)
              Padding(
                child: Text(_info),
                padding: EdgeInsets.only(top: 10),
              ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Text(
                'OldBirds 是一个个人品牌，专注于技术深度探研，跟随于新技术的实践，追求于代码质量的提升，乐忠于技术的分享和宣传...',
                style: TextStyle(fontSize: 16, height: 1.8),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '联系方式',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildLinkInfo('公众号', 'OldBirds'),
                  _buildLinkInfo('邮箱', 'oheroj@gmail.com', onTap: () async {
                    String email = 'oheroj@gmail.com';
                    final Uri _emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: email,
                      queryParameters: {'subject': 'Hello,Oldbirds!'},
                    );
                    final urlString = _emailLaunchUri.toString();
                    if (await canLaunch(urlString)) {
                      launch(urlString);
                    } else {
                      Clipboard.setData(ClipboardData(text: email));
                      showToast('邮箱已复制');
                    }
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLinkInfo(String title, String value,
      {GestureTapCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$title：'),
            TextSpan(
                text: value,
                style: TextStyle(fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = onTap ??
                      () {
                        Clipboard.setData(ClipboardData(text: value));
                        showToast('$title已复制');
                      })
          ],
        ),
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
