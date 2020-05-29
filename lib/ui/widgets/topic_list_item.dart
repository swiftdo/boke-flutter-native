import 'package:flutter/material.dart';
import 'package:oldbirds/routing/routing.dart';
import '../../model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopicListItem extends StatelessWidget {
  final Topic item;
  final int index;
  final GestureTapCallback onTap;

  TopicListItem({this.item, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(TopicDetailRoute, arguments: {"topicId": item.id});
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: item.cover.isEmpty ? _buildTitleContent() : _buildCoverContent(),
      ),
    );
  }

  Widget _buildTitleContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.title,
          style: TextStyle(
              color: Color(0xff333333),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(
            item.remarks,
            style: TextStyle(color: Color(0xff767372), fontSize: 14),
          ),
        ),
        _buildTagsWidget(),
        _buildDivider(),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      padding: EdgeInsets.only(top: 12),
      child: Divider(
        height: 0.5,
      ),
    );
  }

  Widget _buildCoverContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CachedNetworkImage(
            imageUrl: item.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => CircularProgressIndicator()),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            item.title,
            style: TextStyle(
                color: Color(0xff333333),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        _buildTagsWidget(),
        _buildDivider(),
      ],
    );
  }

  Widget _buildTagsWidget() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Wrap(
                spacing: 10,
                children: item.tags.map((tag) {
                  return Container(
                    child: Text(
                      tag.showName,
                      style: TextStyle(color: Color(0xffEF543C)),
                    ),
                  );
                }).toList()),
          ),
          Text(
            item.showTime,
            style: TextStyle(color: Color(0xffA9A6A6), fontSize: 12),
          )
        ],
      ),
    );
  }
}
