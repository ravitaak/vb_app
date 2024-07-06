import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  late Dio dio;
  RetryOnConnectionChangeInterceptor(Dio dioInstance) {
    dio = dioInstance;
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);
    late StreamSubscription streamSubscription;
    if (_shouldRetry(err)) {
      streamSubscription = Connectivity().onConnectivityChanged.listen((result) async {
        if (!result.contains(ConnectivityResult.none) && await hasNetwork()) {
          streamSubscription.cancel();
          dio.fetch(err.requestOptions).then((value) => handler.resolve(value));
        }
      });
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError && err.error != null && err.error is SocketException;
  }
}
