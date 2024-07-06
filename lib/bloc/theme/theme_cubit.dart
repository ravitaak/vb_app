import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vb_app/theme/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(appThemeData[AppTheme.DefaultDark]!)) {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfoPlugin.androidInfo.then((value) {
      if (value.version.sdkInt <= 19) {
        emit(ThemeState(appThemeData[AppTheme.DefaultLightSDK19]!));
      }
    });
  }

  changeTheme(AppTheme theme) => emit(ThemeState(appThemeData[theme]!));
}
