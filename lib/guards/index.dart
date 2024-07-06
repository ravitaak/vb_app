import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:vb_app/routes/index.gr.dart';
import 'package:vb_app/utils/SecureStorage.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    String? accessToken = await SecureStorage.getValue(key: "accessToken");
    log(accessToken.toString(), name: "accesToken");
    if (accessToken != null) {
      resolver.next();
    } else {
      router.push(SignUpScreenRoute());
    }
  }
}
