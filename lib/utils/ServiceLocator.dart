import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vb_app/data/database/db.dart';
import 'package:vb_app/data/services/Constants.dart';
import 'package:vb_app/data/services/interceptors.dart';
import 'package:vb_app/data/services/repository/AuthRepository.dart';
import 'package:vb_app/data/services/repository/MiscRepository.dart';
import 'package:vb_app/data/services/repository/PublicRepository.dart';
import 'package:vb_app/data/services/repository/StatsRepository.dart';
import 'package:vb_app/utils/SecureStorage.dart';

StreamController<bool> pdfOpeningStreamController = StreamController.broadcast();

late Stream<bool> pdfOpeningStream;

Future setupServiceLocator() async {
  pdfOpeningStream = pdfOpeningStreamController.stream;

  String? accessToken = await SecureStorage.getValue(key: "accessToken");

  if (Platform.isIOS) {}

  Directory _dir = await getApplicationDocumentsDirectory();
  Constants.dataDirectory = "${_dir.path}";

  BaseOptions _baseOptions = BaseOptions(headers: {"Authorization": "Bearer $accessToken"}, connectTimeout: Duration(milliseconds: 3000));
  Dio _dio = Dio(_baseOptions);
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

  GetIt.I.registerSingleton<Dio>(_dio);
  GetIt.I.registerSingleton<MiscRepository>(MiscRepository());
  GetIt.I.registerSingleton<StatsRepository>(StatsRepository());

  GetIt.I.registerSingleton<PublicRepository>(PublicRepository());
  GetIt.I.registerSingleton<AuthRepository>(AuthRepository());
  GetIt.I.registerSingleton<Database>(Database());
}

Future unregisterServiceLocator() async {
  if (GetIt.I.isRegistered<Dio>()) await GetIt.I.unregister<Dio>();
  if (GetIt.I.isRegistered<MiscRepository>()) await GetIt.I.unregister<MiscRepository>();
  if (GetIt.I.isRegistered<StatsRepository>()) await GetIt.I.unregister<StatsRepository>();
}

class TrialConsumption {
  int consumption = 0;
  int trialGiven = 0;
  int user;
  DateTime date;

  TrialConsumption({required this.consumption, required this.trialGiven, required this.user, required this.date});

  TrialConsumption copyWith({int? consumption, int? trialGiven, int? user, DateTime? date}) {
    return TrialConsumption(
        consumption: consumption ?? this.consumption, trialGiven: trialGiven ?? this.trialGiven, user: user ?? this.user, date: date ?? this.date);
  }
}
