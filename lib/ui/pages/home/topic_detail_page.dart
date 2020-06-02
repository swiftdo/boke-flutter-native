import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/states/states.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:oldbirds/themes/markdown_style.dart';

class TopicDetailPage extends StatelessWidget {
  final String topicId;
  TopicDetailPage({this.topicId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              styleConfig: MarkdownStyle.buildStyleConfig(context),
            ),
          );
        },
      ),
    );
  }
}
