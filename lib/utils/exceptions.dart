import 'dart:io';

import 'package:wecheck/utils/dialog_helper.dart';
import 'package:dio/dio.dart';

class AppException implements Exception {
  final dynamic error;
  final String message;

  AppException([this.message = 'Some thing went wrong', this.error]);

  factory AppException.network() => AppException(
        'Not connected to the network',
        'NetworkConnectionException',
      );

  factory AppException.system() => AppException('system error');
}

Future<dynamic> handleException(Object e, {Function()? callback}) async {
  var message = '';

  switch (e.runtimeType) {
    case SocketException:
      message = 'no internet.';
      break;
    case DioError:
      var err = _parseDioError(e as DioError);
      if (err is String) {
        message = err;
      } else {
        return err;
      }
      break;
    case AppException:
      message = (e as AppException).message;
      break;
    default:
      message = 'system error.';
  }

  if (message.isNotEmpty) {
    await DialogHelper.confirm(
      message,
      onPositionPressed: callback,
    );
  }

  return null;
}

dynamic _parseDioError(DioError err) {
  try {
    if (err.error is SocketException) {
      return 'no internet.';
    }

    if (err.type == DioErrorType.connectTimeout) {
      return 'connect timeout.';
    }

    if (err.type == DioErrorType.cancel) {
      return err.message;
    }

    return err.response?.data;
  } catch (e) {
    return e.toString();
  }
}
