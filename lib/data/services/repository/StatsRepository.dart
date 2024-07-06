import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:vb_app/data/services/Constants.dart';
import 'package:vb_app/data/services/interceptors.dart';

class StatsRepository {
  Dio _dio = GetIt.I<Dio>();

  StatsRepository() {
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor(_dio));
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  saveButtonEvent(int userId, int eventId) {
    _dio.get(ApiConstants.version1.buttonEvents(userId, eventId));
  }

  saveFeedback(data) {
    _dio.post(ApiConstants.version1.feedback, data: data);
  }
}
