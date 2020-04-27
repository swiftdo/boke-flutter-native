import 'package:loveli_core/loveli_core.dart';
import '../model/model.dart';

class HomeNewsState extends ViewStateRefreshListModel {
  List<Topic> _news;
  List<Topic> get news => _news;

  @override
  Future<List> loadData({int pageNum}) {
    return Future.delayed(Duration(seconds: 1), () {
      return [
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({}),
        Topic.fromMap({})
      ];
    });
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}
