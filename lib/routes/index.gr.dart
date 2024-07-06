// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:vb_app/guards/index.dart' as _i8;
import 'package:vb_app/language.dart' as _i4;
import 'package:vb_app/screens/Auth/index.dart' as _i2;
import 'package:vb_app/screens/Home/home.dart' as _i3;
import 'package:vb_app/screens/Offline/index.dart' as _i5;
import 'package:vb_app/splash.dart' as _i1;

class Router extends _i6.RootStackRouter {
  Router({
    _i7.GlobalKey<_i7.NavigatorState>? navigatorKey,
    required this.authGuard,
  }) : super(navigatorKey);

  final _i8.AuthGuard authGuard;

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i1.SplashScreen(),
      );
    },
    SignUpScreenRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i2.SignUpScreen(),
      );
    },
    HomeWrapperRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i3.HomeWrapper(),
      );
    },
    LanguageScreenRoute.name: (routeData) {
      final args = routeData.argsAs<LanguageScreenRouteArgs>();
      return _i6.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: _i4.LanguageScreen(
          args.hasUserData,
          args.hasToken,
        ),
      );
    },
    OfflineHomeRoute.name: (routeData) {
      return _i6.CupertinoPageX<dynamic>(
        routeData: routeData,
        child: const _i5.OfflineHome(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          SplashScreenRoute.name,
          path: '/',
        ),
        _i6.RouteConfig(
          SignUpScreenRoute.name,
          path: '/Authentication',
        ),
        _i6.RouteConfig(
          HomeWrapperRoute.name,
          path: '/Home',
          guards: [authGuard],
        ),
        _i6.RouteConfig(
          LanguageScreenRoute.name,
          path: '/Language',
        ),
        _i6.RouteConfig(
          OfflineHomeRoute.name,
          path: 'OfflineHome',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreenRoute extends _i6.PageRouteInfo<void> {
  const SplashScreenRoute()
      : super(
          SplashScreenRoute.name,
          path: '/',
        );

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.SignUpScreen]
class SignUpScreenRoute extends _i6.PageRouteInfo<void> {
  const SignUpScreenRoute()
      : super(
          SignUpScreenRoute.name,
          path: '/Authentication',
        );

  static const String name = 'SignUpScreenRoute';
}

/// generated route for
/// [_i3.HomeWrapper]
class HomeWrapperRoute extends _i6.PageRouteInfo<void> {
  const HomeWrapperRoute()
      : super(
          HomeWrapperRoute.name,
          path: '/Home',
        );

  static const String name = 'HomeWrapperRoute';
}

/// generated route for
/// [_i4.LanguageScreen]
class LanguageScreenRoute extends _i6.PageRouteInfo<LanguageScreenRouteArgs> {
  LanguageScreenRoute({
    required bool hasUserData,
    required bool hasToken,
  }) : super(
          LanguageScreenRoute.name,
          path: '/Language',
          args: LanguageScreenRouteArgs(
            hasUserData: hasUserData,
            hasToken: hasToken,
          ),
        );

  static const String name = 'LanguageScreenRoute';
}

class LanguageScreenRouteArgs {
  const LanguageScreenRouteArgs({
    required this.hasUserData,
    required this.hasToken,
  });

  final bool hasUserData;

  final bool hasToken;

  @override
  String toString() {
    return 'LanguageScreenRouteArgs{hasUserData: $hasUserData, hasToken: $hasToken}';
  }
}

/// generated route for
/// [_i5.OfflineHome]
class OfflineHomeRoute extends _i6.PageRouteInfo<void> {
  const OfflineHomeRoute()
      : super(
          OfflineHomeRoute.name,
          path: 'OfflineHome',
        );

  static const String name = 'OfflineHomeRoute';
}
