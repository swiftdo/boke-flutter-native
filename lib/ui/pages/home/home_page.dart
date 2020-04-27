import 'package:flutter/material.dart';
import 'home_blog_page.dart';
import 'home_news_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('阅读'),
        centerTitle: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(34),
          child: Container(
            alignment: Alignment.topLeft,
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorWeight: 4,
              indicatorColor: Color(0xffEF543C),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Color(0xffEF543C),
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              unselectedLabelColor: Color(0xff333333),
              tabs: <Widget>[Tab(text: "新闻"), Tab(text: "博客")],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[HomeNewsPage(), HomeBlogPage()],
      ),
    );
  }
}
