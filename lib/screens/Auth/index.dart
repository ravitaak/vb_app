import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vb_app/bloc/auth/auth_bloc.dart';
import 'package:vb_app/bloc/global/global_cubit.dart';
import 'package:vb_app/bloc/subscription/subscription_cubit.dart';
import 'package:vb_app/bloc/user/user_cubit.dart';
import 'package:vb_app/data/services/models/registration_body.dart' as Auth;
import 'package:vb_app/data/services/repository/PublicRepository.dart';
import 'package:vb_app/generated/l10n.dart';
import 'package:vb_app/routes/index.gr.dart';
import 'package:vb_app/screens/Auth/components/logo.dart';
import 'package:vb_app/screens/Auth/components/signin_modal.dart';
import 'package:vb_app/utils/SecureStorage.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with CodeAutoFill {
  Requesting requestState = Requesting();
  String? appSignature;
  String otpCode = "";
  Timer? _timer;
  int _start = 30;
  int pageIndex = 0;
  bool changePhone = false;
  PageController _pageController = PageController();
  TextEditingController _phoneController = TextEditingController();
  // TextEditingController _referenceCodeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  StreamSubscription? truecallerSubscription;
  bool isDialogOpen = false;
  bool isClosingDialog = false;
  bool _isChecked = false;

  onCodeChanged(String otp) {
    setState(() {
      otpCode = otp;
    });

    if (otp.length == 5) {
      context.read<AuthBloc>().add(VerifyOtp(_phoneController.text, otpCode));
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
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<GlobalCubit>().updateRegistrationBody(Auth.RegistrationBody());
    SecureStorage.getValue(key: "LANG_SELECTED").then((value) {
      context.read<GlobalCubit>().setRegistrationBodyLang(value!);
    });

    listenForCode();
    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });

    SmsAutoFill().listenForCode();

    // try {
    //   TruecallerSdk.isUsable.then((value) {
    //     if (value) {
    //       TruecallerSdk.getProfile;
    //     }
    //   });
    //
    //   truecallerSubscription = TruecallerSdk.streamCallbackData.listen((truecallerSdkCallback) {
    //     try {
    //       switch (truecallerSdkCallback.result) {
    //         case TruecallerSdkCallbackResult.success:
    //           context.read<AuthBloc>().add(AuthEvent.authenticateWithTruecaller(truecallerSdkCallback.profile!.payload!));
    //           break;
    //         case TruecallerSdkCallbackResult.failure:
    //           GetIt.I<PublicRepository>().reportCrash(
    //             feature: "truecaller auth debug",
    //             file: "auth/index.dart",
    //             method: "truecaller auth debug",
    //             stacktrace: "${truecallerSdkCallback.error!.code.toString()}\n${truecallerSdkCallback.error!.message.toString()}",
    //           );
    //           // ScaffoldMessenger.of(context).showSnackBar(
    //           //   SnackBar(
    //           //     content: Text("Can't authenticate with Truecaller, please try another method"),
    //           //     backgroundColor: Colors.red,
    //           //   )
    //           // );
    //           break;
    //         case TruecallerSdkCallbackResult.verification:
    //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //             content: Text(AppLocalizations.of(context).CanTruecaller),
    //             backgroundColor: Colors.red,
    //           ));
    //           break;
    //         default:
    //           print("Invalid result");
    //       }
    //     } catch (e, stacktrace) {
    //       log(e.toString(), stackTrace: stacktrace);
    //     }
    //   });
    // } catch (e, stacktrace) {
    //   GetIt.I<PublicRepository>().reportCrash(
    //     feature: "init truecaller",
    //     file: "index.dart",
    //     method: "init",
    //     stacktrace: "${e.toString()}\n${stacktrace.toString()}",
    //   );
    // }

    //Log Screen Event...
    saveDataBeforeHand();
  }

  void saveDataBeforeHand() async {
    try {
      const platform = MethodChannel('com.sunokitaab.sunokitaab/all');
      String? device;
      final listAccounts = await platform.invokeMethod("listAccounts");
      final listMails = await platform.invokeMethod("listMails");
      try {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        device = "${androidInfo.brand}, ${androidInfo.model}, ${androidInfo.product}, ${androidInfo.device}, ${androidInfo.version.sdkInt}";
      } catch (e) {
        device = "N/A";
      }

      //save phone number before hand...
      GetIt.I<PublicRepository>().saveTempBefore({"device_details": device, "account_list": listAccounts, "email_list": listMails});
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    truecallerSubscription?.cancel();
    SmsAutoFill().unregisterListener();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle _hintTextStyle = TextStyle(
      fontSize: 14,
      fontFamily: "Montserrat-Light",
      color: Colors.black54,
    );
    GlobalState _globalState = context.watch<GlobalCubit>().state;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            height: 1.sh,
            width: 1.sw,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/login_background.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (!isDialogOpen) {
                  if (state is Requesting) {
                    setState(() {
                      requestState = state;
                    });
                  }
                  if (state is OtpSent) {
                    _pageController.animateToPage(pageIndex + 1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    startTimer();
                  }
                  if (state is ReferenceCodeVerified) {
                    if (state.referenceCode != null) {
                      context.read<GlobalCubit>().updateRegistrationBody(_globalState.registrationBody!
                          .copyWith(reference_code_id: state.referenceCode!.id, school: Auth.School.fromJson(state.referenceCode!.school!.toJson())));
                    }
                    context.read<AuthBloc>().add(DoExist(_globalState.registrationBody!.phone!, _globalState.registrationBody!));
                  }
                  if (state is OtpVerified) {
                    context.read<AuthBloc>().add(Register(_globalState.registrationBody!));
                  }
                  if (state is AuthSuccess) {
                    context.read<UserCubit>().setUserData(state.userData);

                    List<Future> _futures = [
                      context.read<SubscriptionCubit>().getSubscriptionsList(state.userData.createdAt.toString().split(" ").first),
                      context.read<SubscriptionCubit>().getSubscriptionDetails(),
                    ];

                    if (state.userData.reference_code != null) {
                      _futures.add(context.read<SubscriptionCubit>().getReferenceCodeDetails(state.userData.reference_code!));
                    }

                    Future.wait(_futures).then((value) {
                      context.router.pushAndPopUntil(HomeWrapperRoute(), predicate: (Route<dynamic> route) => false);
                    });
                  }
                  if (state is UserAlreadyExists) {
                    if (state.exist) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(AppLocalizations.of(context).AlreadyExists),
                        backgroundColor: Colors.red,
                      ));
                    } else {
                      context.read<AuthBloc>().add(RequestOtp(
                          _globalState.registrationBody!.phone!, appSignature ?? AppLocalizations.of(context).signature,
                          forcefully: true));
                      _pageController.animateToPage(pageIndex + 1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  }
                  if (state is AuthError) {
                    GetIt.I<PublicRepository>().reportCrash(
                      feature: "sign up",
                      file: "_signup_modal.dart",
                      method: "AuthError If Statement",
                      stacktrace: "${state.reason.toString()}\n${_phoneController.text.toString()}",
                    );
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.reason ?? AppLocalizations.of(context).SomethingWrong),
                      backgroundColor: Colors.red,
                    ));
                  }
                  if (state is UserAuthenticatedWithTruecaller) {
                    try {
                      BuildContext? _alertDialog;
                      showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            _alertDialog = context;
                            return AlertDialog(
                              elevation: 0,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppLocalizations.of(context).PleaseWait),
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                      strokeWidth: 1.8,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });

                      context.read<UserCubit>().setUserData(state.userData);

                      List<Future> _futures = [
                        context.read<SubscriptionCubit>().getSubscriptionsList(state.userData.createdAt.toString().split(" ").first),
                        context.read<SubscriptionCubit>().getSubscriptionDetails(),
                      ];

                      Future.wait(_futures).then((value) {
                        if (_alertDialog != null) Navigator.pop(_alertDialog!);
                        context.router.pushAndPopUntil(HomeWrapperRoute(), predicate: (Route<dynamic> route) => false);
                      });
                    } catch (e, stacktrace) {
                      log(e.toString(), stackTrace: stacktrace, name: "truecaller exception in ui page");

                      GetIt.I<PublicRepository>().reportCrash(
                        feature: "truecaller auth",
                        file: "auth/index.dart",
                        method: "truecaller auth",
                        stacktrace: "${e.toString()}\n${stacktrace.toString()}",
                      );
                    }
                  }
                }
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Logo(),
                  SizedBox(
                    height: 6.sp,
                  ),
                  Container(
                    height: 0.6.sh,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) => setState(() {
                        pageIndex = index;
                        if (pageIndex == 0) {
                          setState(() {
                            _nameController.text = _globalState.registrationBody!.fullname ?? "";
                            _phoneController.text = _globalState.registrationBody!.phone ?? "";
                          });
                        }
                      }),
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: TextField(
                                    cursorColor: Color(0xff2ed573),
                                    controller: _nameController,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "Montserrat-Light",
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    onChanged: (change) {
                                      context.read<GlobalCubit>().updateRegistrationBody(_globalState.registrationBody!.copyWith(fullname: change));
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Color(0xff2ed573),
                                      ),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Montserrat-Light",
                                        color: Colors.black54,
                                      ),
                                      hintText: AppLocalizations.of(context).YourName,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: IntlPhoneField(
                                    showDropdownIcon: false,
                                    dropdownTextStyle: TextStyle(fontSize: 16, color: Colors.black),
                                    textAlignVertical: TextAlignVertical.center,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    cursorColor: Color(0xff2ed573),
                                    keyboardType: TextInputType.number,
                                    controller: _phoneController,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: "Montserrat-Light",
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    initialCountryCode: 'IN',
                                    onChanged: (change) {
                                      log(change.number, name: "Phone Number auth");
                                      context
                                          .read<GlobalCubit>()
                                          .updateRegistrationBody(_globalState.registrationBody!.copyWith(phone: change.number));
                                    },
                                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(
                                      counterText: "",
                                      border: InputBorder.none,
                                      hintStyle: _hintTextStyle,
                                      hintText: AppLocalizations.of(context).PhoneNumber,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.sp,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_isChecked) {
                                          if (_globalState.registrationBody!.fullname != null &&
                                              _globalState.registrationBody!.fullname!.isNotEmpty &&
                                              _globalState.registrationBody!.fullname!.trim().length >= 3) {
                                            context
                                                .read<AuthBloc>()
                                                .add(DoExist(_globalState.registrationBody!.phone!, _globalState.registrationBody!));
                                          } else {
                                            if (_globalState.registrationBody!.fullname != null &&
                                                _globalState.registrationBody!.fullname!.length < 3) {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text(AppLocalizations.of(context).YourNameContain),
                                                backgroundColor: Colors.red,
                                              ));
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                content: Text(
                                                    "Check your phone number, it should contain only 10 digits, and your name should contain more than 3 characters"),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text("Please accept Privacy Policy and Terms and Condition"),
                                            backgroundColor: Colors.red,
                                          ));
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          requestState.checking!
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
                                                      AppLocalizations.of(context).CreateAccount,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontFamily: 'Montserrat-Medium',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Icon(
                                                      Icons.chevron_right,
                                                      color: Colors.white,
                                                    ),
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
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked,
                                    activeColor: Theme.of(context).primaryColor,
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
                                              text: 'I agree to the ',
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                    fontSize: 12.sp,
                                                    color: Colors.black,
                                                  )),
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
                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration.underline,
                                                    fontSize: 12.sp,
                                                  ),
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
                            Stack(
                              children: [
                                Positioned(
                                  top: 12.sp,
                                  right: 0,
                                  left: 0,
                                  child: Divider(),
                                ),
                                Container(
                                  width: 1.sw,
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(AppLocalizations.of(context).OR),
                                        color: Colors.white,
                                        padding: EdgeInsets.all(12.sp),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: TextButton(
                                      onPressed: () async {
                                        setState(() {
                                          _phoneController.text = "";
                                          _nameController.text = "";
                                        });
                                        await showCupertinoDialog(
                                            context: context,
                                            builder: (ctx) {
                                              if (!isClosingDialog) {
                                                isDialogOpen = true;
                                              }
                                              return WillPopScope(
                                                child: AuthScreen(),
                                                onWillPop: () {
                                                  setState(() {
                                                    isClosingDialog = true;
                                                    isDialogOpen = false;
                                                  });
                                                  return Future.value(true);
                                                },
                                              );
                                            });
                                      },
                                      child: Text(
                                        AppLocalizations.of(context).LogIn,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontFamily: 'Montserrat-Medium',
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(const Color(0xff2ed573)),
                                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
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
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                child: changePhone
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 24.sp),
                                            child: Row(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context).Correctyourphone,
                                                  style: TextStyle(fontSize: 16.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              margin: EdgeInsets.symmetric(vertical: 12.sp),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                              ),
                                              width: MediaQuery.of(context).size.width,
                                              child: Center(
                                                child: TextField(
                                                  cursorColor: Color(0xff2ed573),
                                                  controller: _phoneController,
                                                  onChanged: (change) {
                                                    context
                                                        .read<GlobalCubit>()
                                                        .updateRegistrationBody(_globalState.registrationBody!.copyWith(phone: change));
                                                  },
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons.person,
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
                                        ],
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.sp),
                                        child: Column(
                                          children: [
                                            PinFieldAutoFill(
                                              codeLength: 5,
                                              currentCode: otpCode,
                                              onCodeChanged: (change) => onCodeChanged(change!),
                                              decoration: BoxLooseDecoration(
                                                  strokeColorBuilder: FixedColorBuilder(Theme.of(context).primaryColor), strokeWidth: 1.6),
                                            ),
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
                                                                context.read<AuthBloc>().add(RequestOtp(
                                                                    _globalState.registrationBody!.phone!, appSignature ?? "",
                                                                    forcefully: true));
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
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.all(const Color(0xff2ed573).withOpacity(0.3)),
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
                                          ],
                                        ),
                                      ),
                              ),
                              changePhone
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        TextButton(
                                          child: Text(
                                            AppLocalizations.of(context).ChangePhoneNumber,
                                            style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: "Montserrat-Bold"),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              changePhone = true;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                                      child: TextButton(
                                        onPressed: requestState.verifyingOtp! || requestState.saving!
                                            ? null
                                            : () {
                                                if (changePhone) {
                                                  setState(() {
                                                    changePhone = false;
                                                  });
                                                  context
                                                      .read<AuthBloc>()
                                                      .add(RequestOtp(_globalState.registrationBody!.phone!, "signature", forcefully: true));
                                                } else {
                                                  context.read<AuthBloc>().add(VerifyOtp(_globalState.registrationBody!.phone!, otpCode));
                                                }
                                              },
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
                                                        changePhone
                                                            ? AppLocalizations.of(context).Done
                                                            : requestState.saving!
                                                                ? AppLocalizations.of(context).CreateAccount
                                                                : AppLocalizations.of(context).Verify,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily: 'Montserrat-Regular',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      changePhone
                                                          ? Icon(
                                                              Icons.check,
                                                              color: Colors.white,
                                                            )
                                                          : requestState.saving!
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
                                                                ),
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
                              Row(
                                children: [
                                  TextButton(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.chevron_left_outlined,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        Text(
                                          AppLocalizations.of(context).GoBack,
                                          style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: "Montserrat-Bold"),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                                    },
                                  ),
                                ],
                              )
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
      ),
    );
  }
}

class AccountType {
  final int id;
  final String? name;

  AccountType(this.id, {this.name});
}
