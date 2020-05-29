import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/states/states.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:oldbirds/ui/widgets/widgets.dart';
import 'package:oldbirds/model/model.dart';

class BookletsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('手册'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ProviderWidget(
      model: BookletsState(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, BookletsState newsState, child) {
        return SmartRefresher(
          controller: newsState.refreshController,
          header: WaterDropMaterialHeader(
            color: Color(0xffEF543C),
          ),
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
            slivers: <Widget>[BookletList()],
          ),
        );
      },
    );
  }
}

class BookletList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookletsState state = Provider.of(context);
    if (state.viewState == ViewState.busy) {
      return SliverToBoxAdapter(
        child: SkeletonList(
          builder: (context, index) => BookletListSkeletonItem(),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          Booklet item = state.list[index];
          return BookletListItem(
            item: item,
            index: index,
          );
        },
        childCount: state.list?.length ?? 0,
      ),
    );
  }
}
