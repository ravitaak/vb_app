import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vb_app/generated/l10n.dart';
import 'package:vb_app/utils/SecureStorage.dart';

class OfflineHome extends StatefulWidget {
  const OfflineHome({Key? key}) : super(key: key);

  @override
  _OfflineHomeState createState() => _OfflineHomeState();
}

class _OfflineHomeState extends State<OfflineHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context).YourDownloads,
          style: TextStyle(fontFamily: "Montserrat-ExtraBold", fontSize: 24.sp, color: Colors.black),
        ),
      ),
      body: FutureBuilder<String?>(
        future: SecureStorage.getValue(key: "SUBSCRIPTION"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 34.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/no_subscription.svg',
                      height: 0.4.sh,
                    ),
                    Text(
                      AppLocalizations.of(context).YourSubscriptionExpired,
                      style: TextStyle(fontFamily: "Montserrat-ExtraBold", fontSize: 21.sp),
                    ),
                    Text(
                      AppLocalizations.of(context).PleaseGoBackOnline,
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 34.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/no_subscription.svg',
                    height: 0.4.sh,
                  ),
                  Text(
                    AppLocalizations.of(context).PleaseGoBackOnline,
                    style: TextStyle(fontFamily: "Montserrat-ExtraBold", fontSize: 21.sp),
                  ),
                  Text(
                    AppLocalizations.of(context).Pleaselectures,
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
