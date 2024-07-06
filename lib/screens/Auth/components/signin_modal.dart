import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vb_app/bloc/auth/auth_bloc.dart';
import 'package:vb_app/bloc/subscription/subscription_cubit.dart';
import 'package:vb_app/bloc/user/user_cubit.dart';
import 'package:vb_app/generated/l10n.dart';
import 'package:vb_app/routes/index.gr.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Requesting requestState = Requesting();
  String? appSignature;
  String otpCode = "";
  Timer? _timer;
  int _start = 30;
  bool isAuthor = false;
  TextEditingController _phoneTextController = TextEditingController();
  PageController _pageController = PageController();
  bool isClosingDialog = false;
  StreamSubscription? truecallerSubscription;
  bool _isChecked = false;

  onCodeChanged(String otp) {
    setState(() {
      otpCode = otp;
    });

    if (otp.length == 5) {
      context.read<AuthBloc>().add(VerifyOtp(_phoneTextController.text, otpCode));
    }
  }

  void startTimer() {
    if (_start == 0) {
      setState(() {
        _start = 30;
      });
    }
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (mounted) {
          setState(() {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      SmsAutoFill().getAppSignature.then((signature) {
        setState(() {
          appSignature = signature;
        });
      });

      SmsAutoFill().listenForCode();

      Future.delayed(
          Duration(
            milliseconds: 200,
          ), () async {
        DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
        final androidInfo = await deviceInfoPlugin.androidInfo;
        if (androidInfo.version.sdkInt > 19) {
          final SmsAutoFill _autoFill = SmsAutoFill();
          _autoFill.hint.then((value) => {
                if (value != null)
                  setState(() {
                    if (mounted) {
                      _phoneTextController.text = value.substring(3, 13);
                      context.read<AuthBloc>().add(RequestOtp(_phoneTextController.text, appSignature ?? ""));
                    }
                  })
              });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    SmsAutoFill().unregisterListener();
    _timer?.cancel();
    truecallerSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Requesting) {
              setState(() {
                requestState = state;
              });
            }
            if (state is OtpSent) {
              setState(() {
                isAuthor = state.isAuthor;
              });
              _pageController.animateToPage(1, duration: Duration(milliseconds: 600), curve: Curves.easeInCubic);
              startTimer();
            }
            if (state is OtpVerified) {
              if (_phoneTextController.text.length == 10) {
                context.read<AuthBloc>().add(Login(_phoneTextController.text, isAuthor));
              }
            }
            if (state is AuthSuccess) {
              try {
                context.read<UserCubit>().setUserData(state.userData);

                List<Future> _futures = [
                  context.read<SubscriptionCubit>().getSubscriptionsList(state.userData.createdAt.toString().split(" ").first),
                  context.read<SubscriptionCubit>().getSubscriptionDetails(),
                ];

                Future.wait(_futures).then((value) {
                  context.router.pushAndPopUntil(HomeWrapperRoute(), predicate: (Route<dynamic> route) => false);
                });
              } catch (e, stacktrace) {
                log(e.toString(), stackTrace: stacktrace, name: "exception in signin_modal");
              }
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.reason ?? AppLocalizations.of(context).ErrorAgainlater), backgroundColor: Colors.red));
            }
          },
          child: Container(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 26.sp),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(AppLocalizations.of(context).WelcomeBack,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(fontFamily: "Montserrat-ExtraBold", fontSize: 24.sp)),
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Text(
                                            AppLocalizations.of(context).LoginYourAccount,
                                            style: TextStyle(fontFamily: "Montserrat-Regular", fontSize: 16.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(Radius.circular(12)),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: TextField(
                                        cursorColor: Color(0xff2ed573),
                                        // focusNode: _searchTextFocusNode,
                                        keyboardType: TextInputType.number,
                                        controller: _phoneTextController,
                                        maxLength: 10,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontFamily: "Montserrat-Light",
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).hintColor,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          prefixIcon: Icon(
                                            Icons.phone_android,
                                            color: Color(0xff2ed573),
                                          ),
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Montserrat-Light",
                                            color: Colors.black54,
                                          ),
                                          hintText: AppLocalizations.of(context).PhoneNumber,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        child: TextButton(
                                          onPressed: requestState.sendingOtp!
                                              ? null
                                              : () {
                                                  if (_isChecked) {
                                                    if (_phoneTextController.text.length == 10) {
                                                      context
                                                          .read<AuthBloc>()
                                                          .add(RequestOtp(_phoneTextController.text, appSignature ?? "Signature"));
                                                    } else {
                                                      ScaffoldMessenger.of(context)
                                                          .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).validphonenumber)));
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text("Please agree to Privacy Policy and Terms and Conditions"),
                                                      backgroundColor: Colors.red,
                                                    ));
                                                  }
                                                },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              requestState.sendingOtp!
                                                  ? SizedBox(
                                                      width: 20.sp,
                                                      height: 20.sp,
                                                      child: CircularProgressIndicator(
                                                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                                        strokeWidth: 1.6,
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(context).LogIn,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily: 'Montserrat-Regular',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Icon(
                                                          Icons.chevron_right,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                            ],
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(const Color(0xff2ed573)),
                                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        side: BorderSide(width: 2, color: Theme.of(context).hintColor),
                                        value: _isChecked,
                                        activeColor: Theme.of(context).primaryColor,
                                        overlayColor: MaterialStateProperty.all(Colors.green.shade500),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isChecked = value!;
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: 'I agree to the ', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.sp)),
                                              TextSpan(
                                                  text: 'Terms and Conditions',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 12.sp),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launchUrlString("https://www.sunokitaab.com/terms-and-conditions");
                                                    }),
                                              TextSpan(text: ' and ', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12.sp)),
                                              TextSpan(
                                                  text: 'Privacy Policy',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(color: Colors.blue, decoration: TextDecoration.underline, fontSize: 12.sp),
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = () {
                                                      launchUrlString("https://www.sunokitaab.com/privacy-policy/");
                                                    }),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: .6.sw,
                              child: Text(
                                "${AppLocalizations.of(context).Pleaseprovidetheotp} ${_phoneTextController.text}",
                                style: TextStyle(fontSize: 14.sp, fontFamily: 'Montserrat-Bold'),
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            PinFieldAutoFill(
                                codeLength: 5,
                                currentCode: otpCode,
                                onCodeChanged: (change) => onCodeChanged(change!),
                                decoration: BoxLooseDecoration(
                                  strokeColorBuilder: FixedColorBuilder(Theme.of(context).primaryColor),
                                )),
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${AppLocalizations.of(context).OTPmessage} $_start ${AppLocalizations.of(context).second}",
                                    style: TextStyle(fontSize: 10.sp, fontFamily: 'Montserrat-Bold'),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: _start == 0
                                            ? () {
                                                context.read<AuthBloc>().add(RequestOtp(_phoneTextController.text, appSignature ?? ""));
                                                startTimer();
                                              }
                                            : null,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.refresh,
                                              color: _start == 0 ? Theme.of(context).primaryColor : Colors.white70,
                                              size: 18.sp,
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Text(
                                              AppLocalizations.of(context).resend,
                                              style: TextStyle(
                                                  color: _start == 0 ? Theme.of(context).primaryColor : Colors.white70,
                                                  fontFamily: "Montserrat-Bold"),
                                            )
                                          ],
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(const Color(0xff2ed573).withOpacity(0.2)),
                                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12, horizontal: 12)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 24),
                                  child: TextButton(
                                    onPressed: requestState.verifyingOtp! || requestState.saving!
                                        ? null
                                        : () => context.read<AuthBloc>().add(VerifyOtp(_phoneTextController.text, otpCode)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        requestState.verifyingOtp!
                                            ? SizedBox(
                                                width: 20.sp,
                                                height: 20.sp,
                                                child: CircularProgressIndicator(
                                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                                  strokeWidth: 1.6,
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    requestState.saving! ? AppLocalizations.of(context).LogIn : AppLocalizations.of(context).Verify,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: 'Montserrat-Regular',
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  requestState.saving!
                                                      ? SizedBox(
                                                          width: 18.sp,
                                                          height: 18.sp,
                                                          child: CircularProgressIndicator(
                                                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                                            strokeWidth: 1.6,
                                                          ),
                                                        )
                                                      : Icon(
                                                          Icons.chevron_right,
                                                          color: Colors.white,
                                                        )
                                                ],
                                              )
                                      ],
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(const Color(0xff2ed573)),
                                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
