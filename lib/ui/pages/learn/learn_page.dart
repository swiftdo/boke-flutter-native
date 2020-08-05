import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:oldbirds/routing/routing.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/states/learn_state.dart';
import 'package:oldbirds/ui/ui.dart';
import '../../../model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:oldbirds/routing/routing.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('学习'), centerTitle: false, elevation: 0),
      body: ProviderWidget<LearnState>(
        model: LearnState(),
        onModelReady: (model) => model.getLearn(),
        builder: (context, model, child) {
          if (model.viewState == ViewState.busy || model.data == null) {
            return ViewStateBusyWidget();
          }

          return CustomScrollView(
            slivers: <Widget>[
              _buildTop(model),
              _buildTool(model),
              _buildBooklets(model),
            ],
          );
        },
      ),
    );
  }

  LearnSectionView _buildBooklets(LearnState model) {
    return LearnSectionView(
      padding: EdgeInsets.only(top: 20),
      title: '最新手册',
      child: Column(
        children: model.data.booklets
            .map((item) => BookletListItem(
                  item: item,
                ))
            .toList(),
      ),
    );
  }

  SliverToBoxAdapter _buildTool(LearnState model) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        height: 85.0,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: model.data.tools.length,
          itemBuilder: (context, index) {
            LearnTool tool = model.data.tools[index];
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (tool.type == 1) {
                  Navigator.of(context).pushNamed(BookletsRoute);
                } else if (tool.type == 2) {
                  Navigator.of(context).pushNamed(GamesRoute);
                } else if (tool.type == 3) {
                  // 答案之书
                  Navigator.of(context).pushNamed(AnswerRoute);
                }
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 80.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CachedNetworkImage(
                      height: 60,
                      imageUrl: tool.icon,
                    ),
                    Text(tool.title)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTop(LearnState model) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 16),
        child: CarouselSlider(
          items: model.data.tops.map((item) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (item.type == 1) {
                  // 文章详情
                  Navigator.of(context).pushNamed(
                    TopicDetailRoute,
                    arguments: {"topicId": item.targetId},
                  );
                } else if (item.type == 2) {
                  // 手册
                  Navigator.of(context).pushNamed(
                    BookletRoute,
                    arguments: {"bookletId": item.targetId},
                  );
                }
              },
              child: Container(
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: item.cover,
                            fit: BoxFit.cover,
                            height: 160,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black38,
                                    Colors.black.withAlpha(0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16.0),
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            height: 160,
            viewportFraction: 0.9,
            onPageChanged: (index, reason) {},
          ),
        ),
      ),
    );
  }
}

class LearnBookletView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class LearnSectionView extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets padding;
  const LearnSectionView({
    Key key,
    this.title,
    this.child,
    this.padding = const EdgeInsets.only(left: 16, right: 16, top: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: padding.left > 0 ? 0 : 16),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6,
                    height: 18,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Color(0xff333333),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class LearnSubjectView extends StatelessWidget {
  final String title;
  const LearnSubjectView({
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushNamed(BookletsRoute);
      },
      child: Container(
        width: 60,
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(title),
            )
          ],
        ),
      ),
    );
  }
}
