import 'package:loveli_core/loveli_core.dart';

class MainViewModel extends ViewStateModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
