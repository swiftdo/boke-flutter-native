import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'home_news_page.dart';
import 'package:oldbirds/states/states.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: HomeState(),
      onModelReady: (homeState) {
        homeState.loadSubjects();
      },
      builder: (context, HomeState state, child) {
        if (state.viewState == ViewState.error || state.viewState == ViewState.busy || state.subjects.length == 0) {
          return ViewStateBusyWidget();
        }
        return DefaultTabController(
          length: state.subjects.length,
          child: Scaffold(
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
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    tabs: state.subjects.map((subject) => Tab(text: subject.name)).toList(),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: state.subjects
                  .map((subject) => HomeNewsPage(
                        subjectId: subject.id,
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
