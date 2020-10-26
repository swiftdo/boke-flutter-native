import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/model/model.dart';
import 'package:oldbirds/routing/route_names.dart';

import 'booklet_viewmodel.dart';

class BookletPage extends StatelessWidget {
  final String bookletId; // root catalogId
  BookletPage({
    @required this.bookletId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ProviderWidget(
        model: BookletViewModel(bookletId: bookletId),
        onModelReady: (BookletViewModel state) {
          state.loadData();
        },
        builder: (context, BookletViewModel state, child) {
          if (state.viewState == ViewState.busy) {
            return ViewStateBusyWidget();
          } else if (state.viewState == ViewState.error || state.booklet == null) {
            return Container();
          }
          return CustomScrollView(
            slivers: <Widget>[
              _buildHeader(state),
              _buildCatalogs(state),
            ],
          );
        },
      ),
    );
  }

  SliverList _buildCatalogs(BookletViewModel state) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CatalogTree(
            item: state.catalogs[index],
            onTap: (item) {
              Navigator.of(context)
                  .pushNamed(BookletReadRoute, arguments: {"catalogs": state.catalogs, "catalog": item});
            },
          );
        },
        childCount: state.catalogs.length,
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(BookletViewModel state) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              width: 120,
              height: 160,
              fit: BoxFit.cover,
              imageUrl: state.booklet.cover,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.booklet.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        state.booklet.remarks,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CatalogTree extends StatelessWidget {
  final Catalog item;
  final void Function(Catalog item) onTap;
  final String selectCatalogId;
  const CatalogTree({Key key, this.item, @required this.onTap, this.selectCatalogId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 10 * item.level.toDouble()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(item),
            child: Container(
              width: double.infinity,
              child: Text(
                item.title,
                style: TextStyle(
                    fontSize: 18.0 * (18 - item.level) / 18, color: selectCatalogId == item.id ? Colors.red : null),
              ),
            ),
          ),
          ...item.child.map((e) => CatalogTree(
                item: e,
                selectCatalogId: selectCatalogId,
                onTap: onTap,
              ))
        ],
      ),
    );
  }
}
