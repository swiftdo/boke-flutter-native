import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oldbirds/states/states.dart';
import 'package:oldbirds/ui/ui.dart';
import 'package:provider/provider.dart';
import 'package:sy_flutter_qiniu_storage/sy_flutter_qiniu_storage.dart';
import 'package:oktoast/oktoast.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalUserState>(
      builder: (context, state, child) {
        return Scaffold(
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
                SettingListTitle(
                  title: '更换头像',
                  onTap: () {
                    _showChoiceDialog(context);
                  },
                  trailing: ClipOval(
                    child: CachedNetworkImage(
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      imageUrl: state.user.avatar,
                      placeholder: (context, str) {
                        return SvgPicture.asset(
                          'assets/images/mine_user_not_login.svg',
                          width: 40,
                          height: 40,
                          color: Theme.of(context).primaryColor,
                        );
                      },
                    ),
                  ),
                ),
                SettingListTitle(
                  title: '昵称',
                  trailing: Text(
                    state.user.name,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SettingListTitle(
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
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(cxt, 0);
                },
                child: Text("取消")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(cxt, 1);
                },
                child: Text('拍照'),
              ),
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
      } else if (value == 2) {
        _pickImageFromGallery();
      }
    });
  }

  _pickImageFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    _uploadAvatar(image);
  }

  _pickImageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    _uploadAvatar(image);
  }

  _uploadAvatar(File imageFile) async {
    if (imageFile == null) {
      return;
    }

    var hud = showToastWidget(
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).primaryColor.withOpacity(0.5)
                : Colors.grey.shade200.withOpacity(0.5),
            child: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ),
            width: 150,
            height: 150,
          ),
        ),
      ),
    );

    GlobalUserState state =
        Provider.of<GlobalUserState>(context, listen: false);
    String qiNiuToken = await state.getQiNiuToken();

    final syStorage = new SyFlutterQiniuStorage();
    //监听上传进度
    syStorage.onChanged().listen((dynamic percent) {
      debugPrint(percent);
    });

    String key = DateTime.now().millisecondsSinceEpoch.toString() +
        '_oldbirds.' +
        imageFile.path.split('.').last;
    //上传文件
    UploadResult result =
        await syStorage.upload(imageFile.path, qiNiuToken, key);
    if (result.success) {
      String url =
          'http://source.loveli.site/' + result.result['key'] ?? result.key;
      await state.changeUserAvatar(url);
    }
    hud.dismiss();
    showToast('上传成功');
  }
}
