import 'package:flutter/foundation.dart';
import 'package:loveli_core/loveli_core.dart';
import '../../../model/model.dart';

import 'package:oldbirds/locator.dart';
import 'package:oldbirds/services/services.dart';

class BookletReadViewModel extends ViewStateModel {
  Catalog currentCatalog;
  final BookletReadTitleState titleState;
  final List<Catalog> catalogs;

  Topic _topic;
  Topic get topic => _topic;

  List<Catalog> _flatCatalogs;

  BookletReadViewModel({
    @required this.currentCatalog,
    @required this.catalogs,
    @required this.titleState,
  }) {
    _flatCatalogs = [];
    _setupFlatList(catalogs);
  }

  _setupFlatList(List<Catalog> catalogs) {
    catalogs.forEach((element) {
      _flatCatalogs.add(element);
      _setupFlatList(element.child);
    });
  }

  final repository = locator<NativeRepository>();

  loadTopic() async {
    setBusy();
    try {
      _topic = await repository.topicDetail(currentCatalog.topicId);
      titleState.change(currentCatalog.title);
      setIdle();
    } catch (e, s) {
      setError(e, s);
    }
  }

  int get _indexOfCurrent => _flatCatalogs.indexWhere((element) => element.id == currentCatalog.id);
  bool get canNext => _indexOfCurrent < _flatCatalogs.length - 1;
  bool get canPreview => _indexOfCurrent > 0;

  preview() {
    // 上一页
    int index = _indexOfCurrent;
    if (index > 0) {
      select(_flatCatalogs[index - 1]);
    }
  }

  next() {
    // 下一页
    int index = _indexOfCurrent;
    if (index < _flatCatalogs.length - 1) {
      select(_flatCatalogs[index + 1]);
    }
  }

  select(Catalog item) {
    currentCatalog = item;
    loadTopic();
  }
}

class BookletReadTitleState extends ChangeNotifier {
  String _title;
  String get title => _title;

  BookletReadTitleState({String title}) : _title = title;

  change(String title) {
    _title = title;
    notifyListeners();
  }
}
