import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oldbirds/states/global_user_state.dart';
import 'package:provider/provider.dart';
import 'package:oldbirds/routing/route_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';

import 'package:oktoast/oktoast.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('个人中心'), centerTitle: false, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MineHeader(),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  MineListTitle(
                    title: '意见反馈',
                    icon: Icons.feedback,
                    onTap: _sendFaceBack,
                  ),
                  MineListTitle(
                    title: '主题配置',
                    icon: Icons.color_lens,
                    onTap: () {
                      Navigator.of(context).pushNamed(ThemeRoute);
                    },
                  ),
                  MineListTitle(
                    title: '设置',
                    icon: Icons.settings,
                    showLine: false,
                    onTap: () {
                      Navigator.of(context).pushNamed(SettingRoute);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _sendFaceBack() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appInfo = '${packageInfo.version}(${packageInfo.buildNumber})';
    String path = await _getEmailAttachmentPath();
    final Email email = Email(
      body: 'Hello, Oldbirds\n $appInfo',
      subject: '[OldBirds]意见反馈',
      recipients: ['oheroj@gmail.com'],
      attachmentPaths: [path],
      isHTML: false,
    );
    if (await canLaunch("mailto:oheroj@gmail.com")) {
      try {
        await FlutterEmailSender.send(email);
      } catch (e) {
        showToast('无法发送邮件');
      }
    } else {
      showToast('无法发送邮件');
    }
  }

  Future<String> _getEmailAttachmentPath() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    String deviceString;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceString = _readAndroidBuildData(androidInfo).toString();
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceString = _readIosDeviceInfo(iosInfo).toString();
    }
    String dir = (await getApplicationDocumentsDirectory()).path;
    String name = DateTime.now().millisecondsSinceEpoch.toString() +
        '_oldbirds_faceback.txt';
    File file = File('$dir/$name');
    file.writeAsString(deviceString);
    return file.path;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}

class MineListTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool showLine;
  final GestureTapCallback onTap;
  MineListTitle({this.title, this.icon, this.onTap, this.showLine = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ),
        showLine
            ? Divider(
                height: 0.5,
              )
            : Container()
      ],
    );
  }
}

class MineHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 120,
      child: Consumer<GlobalUserState>(
        builder: (context, state, child) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (state.isLogin) {
                Navigator.of(context).pushNamed(ProfileRoute);
              } else {
                Navigator.of(context).pushNamed(LoginRoute);
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: state.isLogin
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                          imageUrl: state.user.avatar,
                          placeholder: (context, str) {
                            return SvgPicture.asset(
                              'assets/images/mine_user_not_login.svg',
                              width: 80,
                              height: 80,
                              color: Theme.of(context).primaryColor,
                            );
                          },
                        )
                      : SvgPicture.asset(
                          'assets/images/mine_user_not_login.svg',
                          width: 80,
                          height: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          state.isLogin ? state.user.name : '登录',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          state.isLogin ? '查看和编辑个人资料' : '登录以使用更多功能',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xffADADAD)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
