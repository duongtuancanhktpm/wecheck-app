import 'package:wecheck/services/shared_data/storage_service.dart';
import 'package:wecheck/utils/extensions.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = StorageService().token;

    if (!token.isEmptyOrNull) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
