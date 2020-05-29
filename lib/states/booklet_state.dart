import 'package:flutter/foundation.dart';
import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/locator.dart';
import 'package:oldbirds/model/booklet.dart';
import 'package:oldbirds/services/services.dart';

import '../model/model.dart';

class BookletState extends ViewStateModel {
  final String bookletId;
  BookletState({@required this.bookletId});

  Booklet _booklet;
  Booklet get booklet => _booklet;

  List<Catalog> _catalogs;
  List<Catalog> get catalogs => _catalogs;
  final repository = locator<NativeRepository>();

  Future loadData() async {
    setBusy();
    try {
      _booklet = await repository.bookletDetail(bookletId);
      _catalogs = await repository.bookletCatalogs(_booklet.catalogId);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }
}
