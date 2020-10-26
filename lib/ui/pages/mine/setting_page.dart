import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:oldbirds/routing/route_names.dart';
import 'package:oldbirds/states/states.dart';
import 'package:provider/provider.dart';

import '../../widgets/widgets.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String cacheSize;

  @override
  void initState() {
    super.initState();
    getCacheSize();
  }

  void getCacheSize() async {
    //TODO: DefaultCacheManager 有问题。
    // final directory = Directory(await DefaultCacheManager().getFilePath());
    // if (directory.existsSync()) {
    //   FileStat fileStat = directory.statSync();
    //   cacheSize = '${(fileStat.size / 1024.0).toStringAsFixed(2)} MB';
    //   setState(() {});
    // }
  }

  void clearCacheSize() async {
    await DefaultCacheManager().emptyCache();
    getCacheSize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalUserState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text('设置'),
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SettingListTitle(
                  title: '清除缓存',
                  onTap: _clearCacheSize,
                  trailing: Text(
                    cacheSize ?? '0 MB',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SettingListTitle(
                  title: '关于 OldBirds',
                  onTap: () {
                    Navigator.of(context).pushNamed(AboutMeRoute);
                  },
                ),
                state.isLogin
                    ? Container(
                        margin: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            state.logout();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration:
                                BoxDecoration(color: Color(0xffEF543C), borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                            child: Text(
                              '退出登录',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        );
      },
    );
  }

  void _clearCacheSize() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('确定清理缓存？'),
            title: Center(
              child: Text(
                '提示',
                style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    clearCacheSize();
                    Navigator.of(context).pop();
                  },
                  child: Text('确定')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('取消')),
            ],
          );
        });
  }
}
