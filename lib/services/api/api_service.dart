import 'package:wecheck/configurations/environments.dart';
import 'package:wecheck/services/api/app_interceptor.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService extends DioMixin {
  static final ApiService _service = ApiService._internal();

  ApiService._internal() {
    options = BaseOptions(
      baseUrl: Environment.host,
      connectTimeout: Environment.apiTimeout,
    );
    interceptors.addAll([AppInterceptor(), PrettyDioLogger()]);
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  factory ApiService() => _service;
}
