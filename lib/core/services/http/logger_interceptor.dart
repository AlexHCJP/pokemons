import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[${response.requestOptions.method}] ${response.requestOptions.uri.path}');
    return handler.next(response);
  }
}
