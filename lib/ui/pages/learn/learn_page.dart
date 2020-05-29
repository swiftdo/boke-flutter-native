import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:oldbirds/routing/routing.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  List<Widget> get imageSliders => imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                          child: Text(
                            'No. ${imgList.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('学习'), centerTitle: false, elevation: 0),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.only(top: 20),
            child: CarouselSlider(
                items: imageSliders,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {})),
          )),
          LearnSectionView(
            title: '专题',
            child: Wrap(
              runSpacing: 16,
              spacing: (MediaQuery.of(context).size.width - 32 - 4 * 60) / 3,
              children: <Widget>[
                LearnSubjectView(title: '课程'),
                LearnSubjectView(title: '面试题'),
                LearnSubjectView(title: '手册'),
                LearnSubjectView(title: '测一测'),
                LearnSubjectView(title: 'roadmap'),
                LearnSubjectView(title: 'leadcode')
              ],
            ),
          ),
          LearnSectionView(
            title: '热门手册',
            child: Container(
                child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.95,
                initialPage: 1,
                enableInfiniteScroll: false,
              ),
              items: imageSliders,
            )),
          ),
          LearnSectionView(
            title: '热门课程',
            child: Column(
              children: imageSliders,
            ),
          )
        ],
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
  const LearnSectionView({
    Key key,
    this.title,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 18,
                  color: Color(0xff333333),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
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
