import 'dart:core';
import 'dart:developer';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vb_app/bloc/index.dart';
import 'package:vb_app/guards/index.dart';
import 'package:vb_app/routes/index.gr.dart' as GeneratedRoutes;
import 'package:vb_app/theme/app_theme.dart';
import 'package:vb_app/utils/SecureStorage.dart';
import 'package:vb_app/utils/ServiceLocator.dart';

import 'bloc/global/global_cubit.dart';
import 'generated/l10n.dart';
// import 'package:flutter_uxcam/flutter_uxcam.dart';

initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  await setupServiceLocator();

  return App();
}

class App extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale, {bool isSystem = false}) {
    var state = context.findAncestorStateOfType<_AppState>()!;
    state.setLocale(locale);
  }

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final _appRouter = GeneratedRoutes.Router(authGuard: AuthGuard());
  Locale? _locale;
  ThemeData? _theme;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    changeTheme();
  }

  changeTheme() async {
    try {
      final theme = await SecureStorage.getValue(key: "THEME");
      if (theme != null) {
        setState(() {
          _theme = theme == "light" ? appThemeData[AppTheme.DefaultLight]! : appThemeData[AppTheme.DefaultDark]!;
        });
      } else {
        setState(() {
          _theme = appThemeData[AppTheme.DefaultLight]!;
        });
      }
    } catch (e, s) {
      setState(() {
        _theme = appThemeData[AppTheme.DefaultLight]!;
      });
      log(e.toString(), stackTrace: s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          ...providers,
          BlocProvider<GlobalCubit>(
            create: (context) => GlobalCubit(),
          ),
        ],
        child: _theme != null
            ? ThemeProvider(
                initTheme: _theme!,
                builder: (context, theme) {
                  return MaterialApp.router(
                    theme: theme,
                    debugShowCheckedModeBanner: false,
                    locale: _locale ?? Locale("en"),
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                    ],
                    supportedLocales: AppLocalizations.delegate.supportedLocales,
                    routerDelegate: _appRouter.delegate(
                      navigatorObservers: () => [
                        // FirebaseAnalyticsObserver(
                        //   analytics: GetIt.I<FirebaseAnalytics>(),
                        // ),
                        // SentryNavigatorObserver()
                      ],
                    ),
                    routeInformationParser: _appRouter.defaultRouteParser(),
                  );
                },
              )
            : SizedBox());
  }
}
