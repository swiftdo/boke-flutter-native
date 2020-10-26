import 'package:loveli_core/loveli_core.dart';
import '../../../model/model.dart';

import 'package:oldbirds/locator.dart';
import 'package:oldbirds/services/services.dart';

class HomeNewsViewModel extends ViewStateRefreshListModel {
  final String subjectId;
  HomeNewsViewModel(this.subjectId);

  List<Topic> _news;
  List<Topic> get news => _news;

  final repository = locator<NativeRepository>();

  @override
  Future<List> loadData({int pageNum}) async {
    final ModelPage<Topic> res =
        await repository.subjectTopics(subjectId, page: pageNum, per: ViewStateRefreshListModel.pageSize);
    return res.items;
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}
