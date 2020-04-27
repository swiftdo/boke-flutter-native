import 'package:loveli_core/loveli_core.dart';
import '../model/model.dart';

class HomeBlogState extends ViewStateRefreshListModel {
  List<Topic> _topics;
  List<Topic> get topics => _topics;

  @override
  Future<List> loadData({int pageNum}) {
    return null;
  }

  @override
  onCompleted(List data) {
    return super.onCompleted(data);
  }
}
