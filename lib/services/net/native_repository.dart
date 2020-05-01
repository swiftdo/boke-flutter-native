import 'api.dart';
import 'package:dio/dio.dart';
import 'models.dart';

class NativeRepository {
  Future<ModelLogin> login({String email, String pwd}) async {
    var response = await http.post("/auth/login",
        data: FormData.fromMap({"email": email, "password": pwd}));
    return ModelLogin.fromMap(response.data['topic']);
  }
}
