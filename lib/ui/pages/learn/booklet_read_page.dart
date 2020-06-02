import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:oldbirds/model/model.dart';
import 'package:oldbirds/states/booklet_read_state.dart';
import 'package:oldbirds/states/states.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/widgets.dart';
import 'booklet_page.dart';

class BookletReadPage extends StatelessWidget {
  final Catalog catalog; // 当前的
  final List<Catalog> catalogs;
  final BookletReadTitleState titleState;

  BookletReadPage({@required this.catalogs, @required this.catalog})
      : titleState = BookletReadTitleState(title: catalog.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: ChangeNotifierProvider.value(
            value: titleState,
            child:
                Consumer<BookletReadTitleState>(builder: (ctx, state, child) {
              return Text(state.title);
            }),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: ProviderWidget(
            model: BookletReadState(
                currentCatalog: catalog,
                catalogs: catalogs,
                titleState: titleState),
            onModelReady: (BookletReadState state) => state.loadTopic(),
            builder: (context, BookletReadState state, child) {
              if (state.viewState == ViewState.busy) {
                return ViewStateBusyWidget();
              } else if (state.viewState == ViewState.error ||
                  state.topic == null) {
                return Container();
              }
              return _buildTopic(state, context);
            }));
  }

  Widget _buildTopic(BookletReadState state, BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...MarkdownGenerator(
                    data: state.topic.content,
                    childMargin: EdgeInsets.only(top: 16),
                    styleConfig: StyleConfig(
                        imgBuilder: (String url, attributes) {
                          final tag = EncryptUtil.encodeMd5(url);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
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
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xffEF543C)),
                            textStyle: TextStyle(fontSize: 16, height: 1.5),
                            onLinkTap: (url) {
                              launch(url);
                            })),
                  ).widgets,
                ],
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).padding.bottom + 60,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black12, blurRadius: 4)
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    '上一节',
                    style: TextStyle(
                        color:
                            state.canPreview ? Color(0xff333333) : Colors.grey),
                  ),
                  onTap: () {
                    state.preview();
                  },
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              clipBehavior: Clip.hardEdge,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(10),
                                    topRight: const Radius.circular(10),
                                  ),
                                ),
                                child: DraggableScrollableSheet(
                                  initialChildSize: 1,
                                  minChildSize: 0.95,
                                  builder: (BuildContext context,
                                      ScrollController scrollController) {
                                    return ListView.builder(
                                      controller: scrollController,
                                      itemBuilder: (context, index) {
                                        return CatalogTree(
                                            selectCatalogId:
                                                state.currentCatalog.id,
                                            item: state.catalogs[index],
                                            onTap: (item) {
                                              state.select(item);
                                              Navigator.of(context).pop();
                                            });
                                      },
                                      itemCount: state.catalogs.length,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Text(
                    '查看目录',
                    style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    state.next();
                  },
                  child: Text(
                    '下一节',
                    style: TextStyle(
                        color: state.canNext ? Color(0xff333333) : Colors.grey),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
