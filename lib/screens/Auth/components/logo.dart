import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vb_app/generated/l10n.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60.h, bottom: 18),
              child: Text(
                "#PhoneFreeLearning",
                style: TextStyle(
                  color: Color(0xff031c4e),
                  fontSize: 24.sp,
                  fontFamily: 'Montserrat-Bold',
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 0.h, bottom: 14),
              child: Image.asset(
                'assets/images/vb_transparent.png',
                width: .46.sw,
              ),
            )
          ],
        ),
        // Text(
        //   "VidyaBox",
        //   style: TextStyle(
        //     color: Color(0xff031c4e),
        //     fontSize: 24.sp,
        //     fontFamily: 'Montserrat-Bold',
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
          child: Text(
            "Discover the freedom to learn anytime, anywhere with our device.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff406882),
              fontSize: 14.sp,
              fontFamily: 'Montserrat-Regular',
            ),
          ),
        ),
        SizedBox(
          height: .03.sh,
        ),
      ],
    );
  }
}

class RegisterLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h, bottom: 18),
              child: Image.asset(
                'assets/images/white_logo.png',
                width: .21.sw,
              ),
            )
          ],
        ),
        Text(
          "SunoKitaab",
          style: TextStyle(
            color: Color(0xff031c4e),
            fontSize: 18.sp,
            fontFamily: 'Montserrat-Bold',
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
          child: Text(
            AppLocalizations.of(context).Letusknow,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff406882),
              fontSize: 14.sp,
              fontFamily: 'Montserrat-Regular',
            ),
          ),
        ),
        SizedBox(
          height: .06.sh,
        ),
      ],
    );
  }
}
