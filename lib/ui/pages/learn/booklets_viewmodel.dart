import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/model/booklet.dart';
import '../../../model/model.dart';

import 'package:oldbirds/locator.dart';
import 'package:oldbirds/services/services.dart';

class BookletsViewModel extends ViewStateRefreshListModel {
  BookletsViewModel();

  List<Booklet> _booklets;
  List<Booklet> get booklets => _booklets;

  final repository = locator<NativeRepository>();

  @override
  Future<List> loadData({int pageNum}) async {
    final ModelPage<Booklet> res = await repository.booklets(page: pageNum, per: ViewStateRefreshListModel.pageSize);
    return res.items;
  }
}
