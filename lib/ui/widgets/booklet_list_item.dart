import 'package:flutter/material.dart';
import 'package:oldbirds/routing/routing.dart';
import '../../model/model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BookletListItem extends StatelessWidget {
  final Booklet item;
  final int index;
  final GestureTapCallback onTap;

  BookletListItem({this.item, this.index, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(BookletRoute, arguments: {"bookletId": item.id});
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CachedNetworkImage(
                    width: 60,
                    height: 80,
                    fit: BoxFit.cover,
                    imageUrl: item.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    placeholder: (context, url) => CircularProgressIndicator()),
                Expanded(
                  child: Container(
                    height: 80,
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(item.remarks),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 0.5,
            )
          ],
        ),
      ),
    );
  }
}
