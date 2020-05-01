import 'package:oldbirds/model/model.dart';

class ModelLogin {
  Token token;
  User user;

  ModelLogin.fromMap(Map json) {
    token = Token.fromMap(json['token']);
    user = User.fromMap(json['user']);
  }
}
