import 'package:auto_route/auto_route.dart';

class RootAccessGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // if (!(await RootAccess.requestRootAccess)) {
    //   resolver.next();
    // } else {
    //   router.push(SignUpScreenRoute());
    // }
    resolver.next();
  }
}
