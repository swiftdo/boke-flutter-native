import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/states/states.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/widgets.dart';

class TopicDetailPage extends StatelessWidget {
  final String topicId;
  TopicDetailPage({this.topicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('文章详情'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ProviderWidget(
        model: TopicDetailState(topicId: topicId),
        onModelReady: (TopicDetailState state) {
          state.loadTopic();
        },
        builder: (context, TopicDetailState state, child) {
          if (state.viewState == ViewState.error) {
            return Center(
              child: Text('加载错误'),
            );
          }
          if (state.viewState == ViewState.busy) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 30),
            child: MarkdownWidget(
              data: state.topic.showContent,
              childMargin: EdgeInsets.only(top: 16),
              styleConfig: StyleConfig(
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            placeholder: (context, url) => Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                )),
                      ),
                    );
                  },
                  ulConfig: UlConfig(
                      textStyle: TextStyle(fontSize: 16, height: 1.5),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      dotSize: 8,
                      dotMargin: EdgeInsets.only(top: 9, right: 8)),
                  pConfig: PConfig(
                      linkStyle: TextStyle(
                          fontSize: 16, height: 1.5, color: Color(0xffEF543C)),
                      textStyle: TextStyle(fontSize: 16, height: 1.5),
                      onLinkTap: (url) {
                        launch(url);
                      })),
            ),
          );
        },
      ),
    );
  }
}
