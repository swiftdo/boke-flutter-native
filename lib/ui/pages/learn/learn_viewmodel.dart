import 'package:loveli_core/loveli_core.dart';
import 'package:oldbirds/locator.dart';
import 'package:oldbirds/services/services.dart';

import '../../../model/model.dart';

class LearnViewModel extends ViewStateModel {
  final repository = locator<NativeRepository>();

  Learn _data;
  Learn get data => _data;

  getLearn() async {
    setBusy();
    try {
      _data = await repository.getLearn();
      setIdle();
      return _data;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
