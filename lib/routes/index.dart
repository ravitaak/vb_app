import 'package:auto_route/auto_route.dart';
import 'package:vb_app/language.dart';
import 'package:vb_app/screens/Auth/index.dart';
import 'package:vb_app/screens/Home/Premium/v4/thanku_page.dart';
import 'package:vb_app/splash.dart';

import '../guards/index.dart';
import '../screens/Home/Premium/v4/custom_payment_option.dart';
import '../screens/Home/home.dart';
import '../screens/Offline/index.dart';

@AdaptiveAutoRouter(routes: [
  CupertinoRoute(page: SplashScreen, path: "/", initial: true),
  CupertinoRoute(page: SignUpScreen, path: "/Authentication"),
  CupertinoRoute(page: HomeWrapper, path: "/Home", guards: [AuthGuard]),
  CupertinoRoute(page: LanguageScreen, path: "/Language"),
  CupertinoRoute(path: "OfflineHome", page: OfflineHome),
  CupertinoRoute(path: "CustomPaymentScreen", page: CustomPaymentScreen),
  CupertinoRoute(path: "ThankYouPage", page: ThankYouPage),
])
class $Router {}
