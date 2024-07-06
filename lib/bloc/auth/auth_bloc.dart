import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' hide JsonKey;
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:vb_app/data/database/db.dart';
import 'package:vb_app/data/services/Constants.dart';
import 'package:vb_app/data/services/models/reference_code.dart';
import 'package:vb_app/data/services/models/registration_body.dart';
import 'package:vb_app/data/services/repository/AuthRepository.dart';
import 'package:vb_app/data/services/repository/MiscRepository.dart';
import 'package:vb_app/data/services/repository/PublicRepository.dart';
import 'package:vb_app/data/services/repository/StatsRepository.dart';
import 'package:vb_app/utils/SecureStorage.dart';
import 'package:vb_app/utils/ServiceLocator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late String uuid;

  AuthBloc() : super(AuthInitial()) {
    var _uuid = Uuid();

    uuid = _uuid.v4();

    on<AuthEvent>((event, emit) async {
      await _onAuthEvent(event, emit);
    });
  }

  AuthRepository _authRepository = GetIt.I<AuthRepository>();
  static const platform = MethodChannel('com.sunokitaab.sunokitaab/all');

  _onAuthEvent(AuthEvent event, Emitter<AuthState> emit) async {
    if (event is VerifyReferenceCode) {
      final resp = await _authRepository.verifyReferenceCode(event.code);
      emit(ReferenceCodeVerified(resp));
    } else if (event is ToggleSignUp) {
      emit(Requesting(isSignUpOpened: event.open));
    } else if (event is RequestOtp) {
      emit(Requesting(sendingOtp: true));
      final response =
          await _authRepository.requestOtp(event.phone, event.signature == "" ? "signature" : event.signature, forcefully: event.forcefully);

      if (response is! int) {
        emit(OtpSent(response.data["isAuthor"] ?? false));
        emit(Requesting(sendingOtp: false));
      } else {
        emit(AuthError(
            reason: response == 409
                ? "There's already an account registered with this phone number"
                : "There's no user existing with this phone number"));
        emit(Requesting(sendingOtp: false));
      }
    } else if (event is DoExist) {
      try {
        emit(Requesting(checking: true));
        final response = await _authRepository.doExist(event.phone);
        if (response is! int) {
          emit(UserAlreadyExists(response));

          String? device;

          try {
            DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
            AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

            device = "${androidInfo.brand}, ${androidInfo.model}, ${androidInfo.product}, ${androidInfo.device}, ${androidInfo.version.sdkInt}";
          } catch (e) {
            device = "N/A";
          }

          if (!response)
            _authRepository.updateTemp({
              ...event.body.toJson(),
              "device_details": device,
              // "account_list": listAccounts,
              // "email_list": listMails,
            });
        } else {
          emit(AuthError());
        }
        emit(Requesting(checking: false));
      } catch (e, stacktrace) {
        log(e.toString(), name: "exist Err");
        log(stacktrace.toString());
      }
    } else if (event is VerifyOtp) {
      emit(Requesting(verifyingOtp: true));
      final response = await _authRepository.verifyOtp(event.phone, event.otp);
      if (response == 200) {
        emit(OtpVerified());
        emit(Requesting(verifyingOtp: false));
      } else {
        emit(AuthError(reason: "Invalid OTP, please check if you entered the correct OTP"));
        emit(Requesting(verifyingOtp: false));
      }
    } else if (event is Register) {
      try {
        await unregisterServiceLocator();

        emit(Requesting(saving: true));
        String? fcmToken;
        try {
          // fcmToken = await _firebaseMessaging.getToken();
        } catch (e) {
          fcmToken = "FCM_TOKEN";
        }

        String? device;

        try {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          device = "${androidInfo.brand}, ${androidInfo.model}, ${androidInfo.product}, ${androidInfo.device}, ${androidInfo.version.sdkInt}";
        } catch (e) {
          device = "N/A";
        }

        Map<String, dynamic> _data = {
          "fullname": event.body.fullname,
          "phone": event.body.phone,
          // "state": event.body.state!.id!,
          // "district": event.body.district!.id!,
          "fcmToken": fcmToken,
          "appVersion": Constants.versionName,
          "versionCode": Constants.versionCode,
          "device": device,
          "mobilePlatform": Platform.isAndroid ? "Android" : "iOS",
          "lang": event.body.lang,
          "flavor": event.body.flavor
          // "account_list": listAccounts,
          // "email_list": listMails
          // "accountType": event.body
          // "school": event.body.school!.id!,
          // "age": event.body.age,
          // "reference_code": event.body.reference_code_id,
        };

        final responseData = await _authRepository.register(_data);
        await SecureStorage.setValue(key: "accessToken", value: responseData["token"]);

        BaseOptions _baseOptions = BaseOptions();
        _baseOptions.headers = {"Authorization": "Bearer ${responseData["token"]}"};

        try {
          final _referrerId = await SecureStorage.getValue(key: "REFERRER");
          final _uuidId = await SecureStorage.getValue(key: "REFERRER_UUID");
          GetIt.I<PublicRepository>().reportCrash(
            feature: "Referral Id",
            file: "auth_bloc.dart",
            method: "register",
            stacktrace: "Type: ${_referrerId.runtimeType}, Value: ${_referrerId}, UUID: ${_uuidId}",
          );
          if (_referrerId != null && _uuidId != null) {
            GetIt.I<PublicRepository>().updateDynamicData(responseData["id"], int.parse(_referrerId), _uuidId);
          }
        } catch (e, s) {
          GetIt.I<PublicRepository>().reportCrash(
            feature: "Register User",
            file: "auth_bloc.dart",
            method: "register",
            stacktrace: "${e.toString()}\n${s.toString()}",
          );
        }

        GetIt.I.registerSingleton<Dio>(Dio(_baseOptions));
        GetIt.I.registerSingleton<MiscRepository>(MiscRepository());

        GetIt.I.registerSingleton<StatsRepository>(StatsRepository());

        Database _database = GetIt.I<Database>();
        await _database.userDao.removeUser();
        await _database.userDao.addUser(TbUserCompanion.insert(
          id: responseData["id"],
          fullname: event.body.fullname!,
          phone: event.body.phone!,
        ));
        TbUserData? _userData = await _database.userDao.getUser();

        emit(Requesting(saving: false));
        emit(AuthSuccess(userData: _userData!));
      } catch (e, stacktrace) {
        GetIt.I<PublicRepository>().reportCrash(
          feature: "register",
          file: "auth_bloc.dart",
          method: "register",
          stacktrace: "${e.toString()}\n${stacktrace.toString()}",
        );
        emit(AuthError());
        emit(Requesting(saving: false));
      }
    } else if (event is Login) {
      try {
        await unregisterServiceLocator();

        Database _database = GetIt.I<Database>();
        String? fcmToken = "";
        try {
          // fcmToken = await _firebaseMessaging.getToken();
        } catch (e) {
          fcmToken = "FCM_TOKEN";
        }
        emit(Requesting(saving: true));
        dynamic _response = await _authRepository.login(event.phone, fcmToken);
        if (_response is! int) {
          TbUserCompanion _user = TbUserCompanion.insert(
            id: _response["user"]["id"],
            phone: _response["user"]["phone"],
            fullname: _response["user"]["fullname"],
            createdAt: Value(DateTime.parse(_response["user"]["createdAt"])),
          );
          await _database.userDao.removeUser();
          await _database.userDao.addUser(_user);
          TbUserData? _userData = await _database.userDao.getUser();
          await SecureStorage.setValue(key: "accessToken", value: _response["token"]);

          BaseOptions _baseOptions = BaseOptions();
          _baseOptions.headers = {"Authorization": "Bearer ${_response["token"]}"};
          GetIt.I.registerSingleton<Dio>(Dio(_baseOptions));
          GetIt.I.registerSingleton<MiscRepository>(MiscRepository());

          GetIt.I.registerSingleton<StatsRepository>(StatsRepository());
          emit(AuthSuccess(userData: _userData!));
          emit(Requesting(saving: false));
        }
      } catch (e, stacktrace) {
        log(e.toString());
        log(stacktrace.toString());
        GetIt.I<PublicRepository>().reportCrash(
          feature: "login",
          file: "auth_bloc.dart",
          method: "login",
          stacktrace: "${e.toString()}\n${stacktrace.toString()}",
        );
      }
    } else if (event is AuthenticateWithTruecaller) {
      try {
        Database _database = GetIt.I<Database>();

        //get fcm token if possible...
        String? fcmToken;
        try {
          // fcmToken = await _firebaseMessaging.getToken();
        } catch (e) {
          fcmToken = "FCM_TOKEN";
        }

        String? device;

        try {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          device = "${androidInfo.brand}, ${androidInfo.model}, ${androidInfo.product}, ${androidInfo.device}, ${androidInfo.version.sdkInt}";
        } catch (e) {
          device = "N/A";
        }

        Map<String, dynamic> _data = {
          "device": device,
          "mobilePlatform": Platform.isAndroid ? "Android" : "iOS",
          // "account_list": listAccounts,
          // "email_list": listMails
        };

        final _response = await _authRepository.authWithTruecaller(event.payload, fcmToken, device, _data);
        TbUserCompanion _user = TbUserCompanion.insert(
          id: _response["user"]["id"],
          phone: _response["user"]["phone"],
          fullname: _response["user"]["fullname"],
          createdAt: Value(DateTime.parse(_response["user"]["createdAt"])),
        );
        await _database.userDao.removeUser();
        await _database.userDao.addUser(_user);
        TbUserData? _userData = await _database.userDao.getUser();
        await SecureStorage.setValue(key: "accessToken", value: _response["token"]);
        BaseOptions _baseOptions = BaseOptions();
        _baseOptions.headers = {"Authorization": "Bearer ${_response["token"]}"};
        GetIt.I.registerSingleton<Dio>(Dio(_baseOptions));
        GetIt.I.registerSingleton<MiscRepository>(MiscRepository());

        GetIt.I.registerSingleton<StatsRepository>(StatsRepository());
        emit(UserAuthenticatedWithTruecaller(userData: _userData!));
      } catch (e, stacktrace) {
        log(e.toString(), stackTrace: stacktrace, name: "Truecaller Bloc Exception");
        emit(AuthErrorWithTruecaller(reason: "Something went wrong with TrueCaller please login/register with phone number"));
      }
    }
  }
}
