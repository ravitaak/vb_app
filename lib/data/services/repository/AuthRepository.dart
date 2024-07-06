import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:vb_app/data/services/Constants.dart';
import 'package:vb_app/data/services/interceptors.dart';
import 'package:vb_app/data/services/models/reference_code.dart';
import 'package:vb_app/data/services/repository/PublicRepository.dart';

class AuthRepository {
  Dio _dio = Dio();

  AuthRepository() {
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor(_dio));
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future verifyReferenceCode(String code) async {
    Response _resp = await _dio.get(ApiConstants.version1.verifyReferenceCode(code.toUpperCase()));
    if (_resp.data is String && _resp.data.isEmpty) return null;
    return ReferenceCode.fromJson(_resp.data);
  }

  Future requestOtp(String phone, String signature, {bool forcefully = false}) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.verifyPhone(forcefully: forcefully), data: {"phone": phone, "signature": signature});
      return _response;
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future doExist(String phone) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.doExist(phone));
      return jsonDecode(_response.data);
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future verifyOtp(String phone, String otp) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.verifyOtp(phone, otp));
      return _response.statusCode;
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future getLocationDetails() async {
    try {
      Response resp = await _dio.get("http://ip-api.com/json");
      return resp.data;
    } catch (e) {
      rethrow;
    }
  }

  Future register(Map<String, dynamic> body) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.register, data: body);
      return _response.data;
    } on DioException catch (e) {
      GetIt.I<PublicRepository>().reportCrash(
        feature: "register",
        file: "AuthRepository.dart",
        method: "register dio",
        stacktrace: "${e.toString()}\n${e.response?.data.toString()}",
      );
      return e.response?.statusCode;
    }
  }

  Future updateTemp(Map<String, dynamic> body) async {
    try {
      await _dio.put(ApiConstants.version1.saveTempUser, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future login(String phone, String fcmToken) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.login, data: {"phone": phone, "fcmToken": fcmToken});
      return _response.data;
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future authWithTruecaller(String payload, String? fcmToken, String device, data) async {
    try {
      Response _response = await _dio.post(ApiConstants.version1.authWithTruecaller, data: {
        "payload": payload,
        "fcmToken": fcmToken,
        "appVersion": Constants.versionName,
        "versionCode": Constants.versionCode,
        "device": device,
        "verification_type": "TRUE_CALLER",
        ...data
      });

      return _response.data;
    } catch (e) {
      rethrow;
    }
  }
}
