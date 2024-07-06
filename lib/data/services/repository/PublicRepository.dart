// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vb_app/data/services/Constants.dart';
import 'package:vb_app/data/services/interceptors.dart';
import 'package:vb_app/data/services/models/trial_data.dart';
import 'package:vb_app/data/services/models/trial_details.dart';

import '../models/district.dart';
import '../models/states.dart';

class PublicRepository {
  BaseOptions _baseOptions = BaseOptions(connectTimeout: Duration(milliseconds: 3000));
  late Dio _dio;

  PublicRepository() {
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(RetryOnConnectionChangeInterceptor(_dio));
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      logPrint: log,
      retries: 2,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 2),
      ],
    ));
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  Future getStates() async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.getStates);
      return _response.data.map<States>((e) => States.fromJson(e)).toList();
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future getDistricts(int stateId) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.getDistricts(stateId));
      return _response.data.map<District>((e) => District.fromJson(e)).toList();
    } on DioException catch (e) {
      return e.response?.statusCode;
    }
  }

  Future getSettingsValue(String keyId) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();

      Response response = await _dio.get(ApiConstants.version1.getSettings(keyId));
      stopwatch.stop();
      // log('time elapsed ${stopwatch.elapsed}', name: "getSettingsValue: $keyId");
      return response.data;
    } on DioException catch (e) {
      return e.response!.statusCode!;
    }
  }

  sendTelegramMessage(String message) {
    _dio.post(ApiConstants.version1.sendTelegramMessage, data: {"message": message});
  }

  sendVBTelegramMessage(int user, String event) {
    _dio.post(ApiConstants.version1.sendVBTelegramMessage, data: {"user": user, "event": event});
  }

  sendTelegramMessageVideoEvents(String message) {
    _dio.post(ApiConstants.version1.sendTelegramMessageVideoEvents, data: {"message": message});
  }

  sendTelegramMessagePremiumScreen(String username, String phone) {
    _dio.post(ApiConstants.version1.sendTelegramMessagePremiumScreen, data: {"fullname": username, "phone": phone});
  }

  Future getTrialDetails(int user) async {
    try {
      Response _response =
          await _dio.post(ApiConstants.version1.trialDetails, data: {"user": user, "date": DateFormat("yyyy-MM-dd").format(DateTime.now())});
      return TrialDetails.fromJson(_response.data);
    } on DioException catch (e) {
      log(e.toString(), name: "getTrialDetails");
      return null;
    }
  }

  Future getTrialStartDate(int user) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();
      Response _response = await _dio.get(ApiConstants.version1.getTrialStartDateV2(user))
        ..requestOptions.connectTimeout = Duration(milliseconds: 1200);

      stopwatch.stop();
      log('time elapsed ${stopwatch.elapsed}', name: "getTrialStartDate");
      return TrialData.fromJson(_response.data);
    } catch (e) {
      rethrow;
    }
  }

  requestAdForChapter(data) {
    _dio.post(ApiConstants.version1.chapterUnlockFromAd, data: data);
  }

  updateRequestAdForChapter(data) {
    _dio.put(ApiConstants.version1.updateChapterUnlockFromAd, data: data);
  }

  Future getCacheValue(String key) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.getCacheValue(key));
      log(_response.data.toString(), name: "Response Data");
      return jsonDecode(_response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future getSurvey(int user) async {
    try {
      Stopwatch stopwatch = Stopwatch()..start();

      Response _response = await _dio.get(ApiConstants.version1.getSurvey(user));

      stopwatch.stop();
      log('time elapsed ${stopwatch.elapsed}', name: "getSurvey");
      return _response.data;
    } on DioException catch (e) {
      return e.response!.statusCode!;
    }
  }

  submitFeedback(String feedback, int user, int featureType) {
    return _dio.post(ApiConstants.version1.feedback, data: {"text": feedback, "feedbackFeature": featureType, "user": user});
  }

  Future saveTempBefore(Map<String, dynamic> body) async {
    try {
      await _dio.post(ApiConstants.version1.saveTempUser, data: body);
    } catch (e) {
      rethrow;
    }
  }

  Future getStringCacheValue(String key) async {
    try {
      Response _response = await _dio.get(ApiConstants.version1.getCacheValue(key));
      return _response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> pushDynamicData(data) async {
    Response _response = await _dio.post(ApiConstants.version1.pushDynamicData, data: data);
    return _response.data;
  }

  Future<dynamic> updateDynamicData(int lead, int leadOwner, String uuid) async {
    Response _response = await _dio.put(ApiConstants.version1.pushDynamicData, data: {"lead": lead, "leadOwner": leadOwner, "uuid": uuid});
    return _response.data;
  }

  reportCrash({String? file, String? method, String? feature, String? stacktrace, int? user}) async {
    String platformVersion;
    try {
      platformVersion = Platform.version;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    try {
      projectVersion = Constants.versionName;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    _dio.post(ApiConstants.version1.reportCrash, data: {
      "file": file,
      "method": method,
      "feature": feature,
      "stacktrace": stacktrace,
      "user": user,
      "version": projectVersion,
      "platform": platformVersion
    });
  }
}
