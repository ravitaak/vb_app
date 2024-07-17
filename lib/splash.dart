import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:vb_app/app.dart';
import 'package:vb_app/bloc/subscription/subscription_cubit.dart';
import 'package:vb_app/bloc/user/user_cubit.dart';
import 'package:vb_app/data/database/db.dart';
import 'package:vb_app/routes/index.gr.dart';
import 'package:vb_app/utils/ScreenUtil.dart';
import 'package:vb_app/utils/SecureStorage.dart';

import 'bloc/vb/vidya_box_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Database _database = GetIt.I<Database>();

  Future<TbUserData?> setUser() async {
    try {
      TbUserData? userData;
      try {
        userData = await _database.userDao.getUser();
      } catch (e) {
        log("User data is null");
      }
      if (userData != null) {
        context.read<UserCubit>().setUserData(userData);
        late List<Future> _futures;
        try {
          _futures = [
            context.read<SubscriptionCubit>().getSubscriptionDetails(),
            context.read<VidyaBoxCubit>().getUrl(),
            context.read<SubscriptionCubit>().getSubscriptionsList(userData.createdAt.toString().split(" ").first),
            Future.delayed(const Duration(milliseconds: 1000)),
          ];
        } catch (fe) {}

        if (userData.reference_code != null) {
          _futures.add(context.read<SubscriptionCubit>().getReferenceCodeDetails(userData.reference_code!));
        }

        await Future.wait(_futures);
      } else {
        await Future.delayed(const Duration(milliseconds: 1600));
      }
      return userData;
    } catch (e, s) {
      log(e.toString() + "JIII", name: "userData catch", stackTrace: s);

      await Future.delayed(const Duration(milliseconds: 1600));
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    Connectivity().checkConnectivity().then((value) async {
      if (value.contains(ConnectivityResult.none)) {
        try {
          TbUserData? userData = await _database.userDao.getUser();
          if (userData != null) {
            context.read<UserCubit>().setUserData(userData);
          }
        } catch (e) {}

        context.router.pushAndPopUntil(OfflineHomeRoute(), predicate: (Route<dynamic> route) => false);
      } else {
        setUser().then((u) async {
          try {
            final accessToken = await SecureStorage.getValue(key: "accessToken");

            App.setLocale(context, Locale('en'));
            if (u == null && accessToken != null) {
              context.router.pushAndPopUntil(SignUpScreenRoute(), predicate: (Route<dynamic> route) => false);
            } else {
              context.router.pushAndPopUntil(HomeWrapperRoute(), predicate: (Route<dynamic> route) => false);
            }
          } catch (e, s) {
            log(e.toString(), stackTrace: s);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing.init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/vb_logo.png',
                fit: BoxFit.fill,
                width: 150.w,
                height: 150.w,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "VidyaBox",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            LoadingAnimationWidget.prograssiveDots(
              color: Color(Theme.of(context).primaryColor.value),
              size: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
