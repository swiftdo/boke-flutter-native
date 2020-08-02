import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:loveli_core/loveli_core.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
//    options.baseUrl = 'https://sb.loveli.site/api';
    options.baseUrl = 'http://oldbirds.qicp.vip/api';
    interceptors.add(NativeApiInterceptor());
  }
}

class NativeApiInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    ResponseData respData = ResponseData.fromJson(response.data);
    debugPrint('数据返回 ${response.data}');
    if (respData.success) {
      response.data = respData.data;
      return http.resolve(response);
    } else {
      throw NotSuccessException.fromRespData(respData);
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => code == 0;
  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
