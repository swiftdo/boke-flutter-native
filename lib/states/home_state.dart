import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/locator.dart';
import 'package:oldbirds/services/services.dart';

import '../model/model.dart';

class HomeState extends ViewStateModel {
  List<Subject> _subjects = [];
  List<Subject> get subjects => _subjects;

  final repository = locator<NativeRepository>();

  Future<List> loadSubjects() async {
    setBusy();
    try {
      _subjects = await repository.subjectAll();
      setIdle();
      return _subjects;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
