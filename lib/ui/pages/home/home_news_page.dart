import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/model/model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import '../../widgets/widgets.dart';
import 'home_news_viewmodel.dart';

class HomeNewsPage extends StatefulWidget {
  final String subjectId;
  HomeNewsPage({@required this.subjectId});

  @override
  _HomeNewsPageState createState() => _HomeNewsPageState();
}

class _HomeNewsPageState extends State<HomeNewsPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: HomeNewsViewModel(widget.subjectId),
      onModelReady: (HomeNewsViewModel model) => model.initData(),
      builder: (context, HomeNewsViewModel newsState, child) {
        return SmartRefresher(
          controller: newsState.refreshController,
          header: WaterDropMaterialHeader(),
          footer: ClassicFooter(
              idleText: '上拉加载',
              loadingText: '加载中…',
              noDataText: '没有更多数据',
              failedText: '加载失败',
              canLoadingText: '松手开始加载数据'),
          enablePullDown: newsState.list.isNotEmpty,
          enablePullUp: newsState.list.isNotEmpty,
          onLoading: newsState.loadMore,
          onRefresh: () async {
            await newsState.refresh();
            newsState.showErrorMessage(context);
          },
          child: CustomScrollView(
            slivers: <Widget>[HomeTopicList()],
          ),
        );
      },
    );
  }
}

class HomeTopicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeNewsViewModel state = Provider.of(context);
    if (state.viewState == ViewState.busy) {
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => TopicSkeletonItem(),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Topic item = state.list[index];
          return TopicListItem(
            item: item,
            index: index,
          );
        },
        childCount: state.list?.length ?? 0,
      ),
    );
  }
}
