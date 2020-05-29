import 'package:oldbirds/locator.dart';
import 'package:oldbirds/services/services.dart';
import '../model/model.dart';
import 'package:loveli_core/loveli_core.dart';

class TopicDetailState extends ViewStateModel {
  final String topicId;

  TopicDetailState({this.topicId});

  Topic _topic;
  Topic get topic => _topic;

  final repository = locator<NativeRepository>();

  Future<Topic> loadTopic() async {
    setBusy();
    try {
      _topic = await repository.topicDetail(topicId);
      setIdle();
      return _topic;
    } catch (e, s) {
      setError(e, s);
      return null;
    }
  }
}
