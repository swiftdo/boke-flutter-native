import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loveli_core/loveli_core.dart';
import '../ui/widgets/widgets.dart';

class MarkdownStyle {
  static StyleConfig buildStyleConfig(BuildContext context) {
    bool isDark =
        Theme.of(context).brightness == Brightness.dark ? true : false;

    return StyleConfig(
      markdownTheme:
          isDark ? MarkdownTheme.darkTheme : MarkdownTheme.lightTheme,
      imgBuilder: (String url, attributes) {
        final tag = EncryptUtil.encodeMd5(url);
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return FullScreenImage(imageUrl: url, tag: tag);
            }));
          },
          child: Hero(
            tag: tag,
            child: CachedNetworkImage(
              imageUrl: url,
              errorWidget: (context, url, error) => Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/images/image_load_error.svg',
                  width: 60,
                  height: 60,
                ),
              ),
              placeholder: (context, url) => Container(
                width: MediaQuery.of(context).size.width,
                height: 160,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
      titleConfig: TitleConfig(
        showDivider: false,
      ),
      ulConfig: UlConfig(
        textStyle: TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
        crossAxisAlignment: CrossAxisAlignment.start,
        dotSize: 8,
        dotMargin: EdgeInsets.only(top: 9, right: 8),
      ),
      pConfig: PConfig(
        linkStyle: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Color(0xff1abc9c),
        ),
        textStyle: TextStyle(fontSize: 16, height: 1.5),
        onLinkTap: (url) {
          launch(url);
        },
      ),
    );
  }
}
