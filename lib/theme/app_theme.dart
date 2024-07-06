import 'package:flutter/material.dart';

enum AppTheme { DefaultLight, DefaultLightSDK19, DefaultDark }

final appThemeData = {
  AppTheme.DefaultLight: ThemeData(
    dialogBackgroundColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
    iconTheme: IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Colors.white,
    hintColor: Colors.black,
    primaryColor: Color(0xff2ed573),
    primaryColorLight: Colors.white,
    cardColor: Color(0xffd2f3e0),
    fontFamily: 'Montserrat-Regular',
    sliderTheme: SliderThemeData(
      inactiveTrackColor: Color(0xffd2f3e0),
      thumbColor: Color(0xff2ed573),
      activeTrackColor: Color(0xff2ed573),
    ),
    hoverColor: Color(0xff2ed573).withOpacity(.8),
    textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Montserrat-Bold',
          color: Color(0xff031c4e),
        ),
        displayMedium: TextStyle(
          color: Color(0xff17361f),
          fontFamily: 'Montserrat-Bold',
        ),
        displaySmall: TextStyle(
          color: Color(0xff031c4e),
          fontFamily: 'Montserrat-Bold',
        ),
        headlineMedium: TextStyle(
          color: Color(0xff2ed573),
          fontFamily: 'Montserrat-Bold',
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
          fontFamily: 'Montserrat-Bold',
        ),
        titleMedium: TextStyle(
          fontFamily: 'Montserrat-Regular',
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontFamily: 'Montserrat-Regular',
          color: Colors.black,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Montserrat-Regular',
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Montserrat-Regular',
          color: Colors.black.withOpacity(0.6),
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff2ed573),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0, backgroundColor: Color(0xff2ed573), selectedItemColor: Colors.white, unselectedItemColor: Colors.white.withOpacity(0.64)),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      onPrimary: Colors.white,
      secondary: Color(0xff2ed573),
      background: Colors.white,
      brightness: Brightness.light,
    ),
  ),
  AppTheme.DefaultLightSDK19: ThemeData(
    primaryColorLight: Colors.white,
    brightness: Brightness.light,
    hintColor: Colors.black,
    primaryColor: Color(0xff2ed573),
    cardColor: Color(0xffd2f3e0),
    fontFamily: 'Martel-Regular',
    sliderTheme: SliderThemeData(
      inactiveTrackColor: Color(0xffd2f3e0),
      thumbColor: Color(0xff2ed573),
      activeTrackColor: Color(0xff2ed573),
    ),
    hoverColor: Color(0xff2ed573).withOpacity(.8),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Martel-Bold',
        color: Color(0xff031c4e),
      ),
      displayMedium: TextStyle(
        color: Color(0xff17361f),
        fontFamily: 'Martel-Bold',
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat-Bold',
      ),
      titleMedium: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Martel-Regular',
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.black.withOpacity(0.5),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff2ed573),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0, backgroundColor: Color(0xff2ed573), selectedItemColor: Colors.white, unselectedItemColor: Colors.white.withOpacity(0.64)),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xff2ed573), background: Colors.white, brightness: Brightness.light),
  ),
  AppTheme.DefaultDark: ThemeData(
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff1e1e1e)),
    dialogBackgroundColor: Color(0xff1e1e1e),
    hintColor: Colors.white,
    primaryColorLight: Color(0xff1e1e1e),
    primaryColor: Color(0xff2ed573),
    fontFamily: 'Montserrat-Regular',
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff2ed573),
      elevation: 0,
    ),
    hoverColor: Color(0xff353733),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0, backgroundColor: Color(0xff2ed573), selectedItemColor: Colors.white, unselectedItemColor: Colors.white.withOpacity(0.64)),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Montserrat-Bold',
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Montserrat-Bold',
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat-Bold',
      ),
      displaySmall: TextStyle(
        // color: Color(0xff031c4e),
        color: Colors.white,
        fontFamily: 'Montserrat-Bold',
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Montserrat-Bold',
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.white54,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.white54,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Montserrat-Regular',
        color: Colors.white54,
      ),
    ),
    cardColor: Color(0xff1e1e1e),
    sliderTheme: SliderThemeData(
      inactiveTrackColor: Color(0xffd2f3e0),
      thumbColor: Color(0xff2ed573),
      activeTrackColor: Color(0xff2ed573),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(onPrimary: Colors.black, secondary: Color(0xff1e1e1e), background: Color.fromARGB(255, 44, 44, 44), brightness: Brightness.dark),
    iconTheme: IconThemeData(color: Colors.white),
  )
};
