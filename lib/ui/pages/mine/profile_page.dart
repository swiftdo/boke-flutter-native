import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oldbirds/states/states.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalUserState>(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: Text('完善资料'),
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
                ProfileListTitle(
                  title: '更换头像',
                  onTap: () {
                    _showChoiceDialog(context);
                  },
                  trailing: CachedNetworkImage(
                    imageUrl: state.user.avatar,
                    placeholder: (context, str) {
                      return SvgPicture.asset(
                        'assets/images/mine_user_not_login.svg',
                        width: 50,
                        height: 50,
                      );
                    },
                  ),
                ),
                ProfileListTitle(
                  title: '昵称',
                  trailing: Text(
                    state.user.name,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ProfileListTitle(
                  title: '邮箱',
                  trailing: Text(state.user.email,
                      style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _showChoiceDialog(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (cxt) {
          return CupertinoActionSheet(
            cancelButton:
                CupertinoActionSheetAction(onPressed: () {}, child: Text("取消")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(cxt, 1);
                  },
                  child: Text('拍照')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(cxt, 2);
                  },
                  child: Text('手机相册')),
            ],
          );
        }).then((value) {
      if (value == 1) {
        _pickImageFromCamera();
      } else {
        _pickImageFromGallery();
      }
    });
  }

  _pickImageFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
  }

  _pickImageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
  }
}

class ProfileListTitle extends StatelessWidget {
  final String title;
  final Widget trailing;
  final GestureTapCallback onTap;

  const ProfileListTitle({Key key, this.trailing, this.title, this.onTap})
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
          color: Color(0xfff4f4f4),
        )
      ],
    );
  }
}
