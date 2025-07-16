import 'package:dio/dio.dart';
import 'package:laa26/core/services/http/logger_interceptor.dart';

class HttpService {
  HttpService._(this._dio);

  factory HttpService.factory() {
    return HttpService._(Dio(BaseOptions(baseUrl: _baseUrl))..interceptors.add(LoggerInterceptor()));
  }

  final Dio _dio;
  static const String _baseUrl = 'https://pokeapi.co/api/v2/pokemon';

  Dio get dio => _dio.clone();
}
