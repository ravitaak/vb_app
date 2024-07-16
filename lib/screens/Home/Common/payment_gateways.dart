import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
// import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart' as RZP;
import 'package:url_launcher/url_launcher.dart';
import 'package:vb_app/bloc/global/global_cubit.dart';
import 'package:vb_app/bloc/private/private_cubit.dart';
import 'package:vb_app/bloc/subscription/subscription_cubit.dart';
import 'package:vb_app/bloc/user/user_cubit.dart';
import 'package:vb_app/data/database/db.dart';
import 'package:vb_app/data/services/Constants.dart';
import 'package:vb_app/data/services/models/Coupon.dart';
import 'package:vb_app/data/services/models/V3Subscription.dart';
import 'package:vb_app/data/services/models/razorpay_subscription.dart';
import 'package:vb_app/data/services/models/user_subscription.dart';
import 'package:vb_app/data/services/repository/PublicRepository.dart';
import 'package:vb_app/generated/l10n.dart';
import 'package:vb_app/routes/index.gr.dart';
import 'package:vb_app/screens/Home/Common/loading_overlay.dart';

enum PurchaseType { Chapter, Subscription, VidyaBox }

class PaymentGateway {
  Widget iconBuilder(String gateway) {
    return Container(
      width: 60,
      height: 60,
      child: Center(
        child: Builder(
          builder: (context) {
            switch (gateway) {
              case "PhonePe":
                return Image.asset(
                  'assets/images/phonepe.png',
                  height: 0.11.sw,
                );
              case "Razorpay":
                return Image.asset('assets/images/razorpay.png');
              case "GPay":
                return Image.asset(
                  'assets/images/google_pay.png',
                  height: 0.11.sw,
                );
              case "Paytm":
                return Image.asset('assets/images/paytm.png', height: 0.06.sw);
              case "UPI":
                return Image.asset('assets/images/upi.png', height: 0.1.sw);
              case "Study Now, Pay Later":
                return Icon(Icons.history_sharp, color: Theme.of(context).primaryColor);
              default:
                return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget show(BuildContext context, List<Gateway> gateways, PurchaseType purchaseType, PaymentBody paymentBody) {
    Coupon? coupon = context.read<PrivateCubit>().state.currentAppliedCoupon;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: gateways
          .map<Widget>(
            (e) => InkWell(
                onTap: () async {
                  switch (e.name) {
                    case "Paytm":
                      {
                        // Paytm _paytmGateway = Paytm();
                        // _paytmGateway.create(context, purchaseType, paymentBody.copyWithCoupon(coupon: coupon?.id));
                      }
                      break;
                    case "UPI":
                      {
                        // LoadingOverlay _loadingOverlay = LoadingOverlay(context);
                        // _loadingOverlay.show();
                        // String _defaultUpiGateway = await context.read<GlobalCubit>().getDefaultUPIGateway();
                        // _loadingOverlay.hide();
                        // if(_defaultUpiGateway == "paytm") {
                        //   Paytm _paytmGateway = Paytm(upi: true);
                        //   _paytmGateway.create(context, purchaseType, paymentBody.copyWithCoupon(coupon: coupon?.id));
                        // } else {
                        //   Razorpay _rzp = Razorpay(upi: true);
                        //   _rzp.create(context, purchaseType, paymentBody.copyWithCoupon(coupon: coupon?.id));
                        // }
                      }
                      break;
                    case "Razorpay":
                      {
                        Razorpay _rzp = Razorpay();
                        _rzp.create(context, purchaseType, paymentBody.copyWith(coupon: coupon?.id, payLater: false));
                      }
                      break;
                    case "Study Now, Pay Later":
                      {
                        Razorpay _rzp = Razorpay();
                        _rzp.create(context, purchaseType, paymentBody.copyWith(coupon: coupon?.id, payLater: true));
                      }
                  }
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        iconBuilder(e.name!),
                        SizedBox(width: 24),
                        Column(
                          children: [
                            Text(
                              e.name!,
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14, fontFamily: "Montserrat-Bold"),
                            ),
                            e.description != null
                                ? Text(
                                    e.description!,
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          fontSize: 12,
                                        ),
                                  )
                                : SizedBox()
                          ],
                        ),
                        paymentBody.subscription != null
                            ? paymentBody.subscription!.recommendedGateway != null
                                ? gateways.firstWhere((element) => element.id == paymentBody.subscription!.recommendedGateway!).id == e.id
                                    ? Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    color: Theme.of(context).primaryColor,
                                                    size: 14,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(context).Recommended,
                                                    style: TextStyle(
                                                        fontFamily: "Montserrat-Bold", color: Theme.of(context).primaryColor, fontSize: 10.sp),
                                                  )
                                                ],
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).cardColor.withOpacity(0.4), borderRadius: BorderRadius.circular(50)),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SizedBox()
                                : SizedBox()
                            : SizedBox(),
                      ],
                    ),
                    Divider(),
                  ],
                )),
          )
          .toList(),
    );
  }
}

class PaymentBody {
  final int? amount;
  final Subscription? subscription;
  final int? chapterId;
  final int? podcast;
  final int? podcastIndex;
  final int? couponId;
  final bool? recurring;
  final bool? payLater;

  //for vidyaBox...
  final bool? withOrder;
  final String? preferredMedium;
  final String? preferredClass;

  PaymentBody(
      {this.amount,
      this.couponId,
      this.preferredClass,
      this.preferredMedium,
      this.subscription,
      this.chapterId,
      this.podcast,
      this.podcastIndex,
      this.recurring,
      this.withOrder,
      this.payLater = false});

  PaymentBody copyWithCoupon({int? coupon}) {
    return PaymentBody(
        recurring: this.recurring,
        preferredMedium: this.preferredMedium,
        preferredClass: this.preferredMedium,
        withOrder: this.withOrder,
        amount: this.amount,
        subscription: this.subscription,
        couponId: coupon ?? this.couponId,
        chapterId: this.chapterId,
        podcast: this.podcast,
        podcastIndex: this.podcastIndex);
  }

  PaymentBody copyWith({int? coupon, bool? payLater}) {
    return PaymentBody(
        recurring: this.recurring,
        preferredMedium: this.preferredMedium,
        preferredClass: this.preferredMedium,
        withOrder: this.withOrder,
        amount: this.amount,
        subscription: this.subscription,
        couponId: coupon ?? this.couponId,
        payLater: payLater ?? this.payLater,
        chapterId: this.chapterId,
        podcast: this.podcast,
        podcastIndex: this.podcastIndex);
  }
}

// class Paytm extends PaymentGateway {
//   late bool upi;
//
//   Paytm({ this.upi = false });
//
//   Future create(BuildContext context, PurchaseType purchaseType, PaymentBody paymentBody) async {
//     final _loadingOverlay = LoadingOverlay(context);
//     _loadingOverlay.show();
//
//     UserLoaded user = context.read<UserCubit>().state as UserLoaded;
//     PaytmOrder? _paytmOrder;
//     switch(purchaseType) {
//       case PurchaseType.Chapter:
//         _paytmOrder = await context.read<SubscriptionCubit>().createOrderForChaptersWithPaytm(
//           paymentBody.amount!,
//           user.userData!.id,
//           upi: upi,
//           chapter: paymentBody.chapterId,
//           podcast: paymentBody.podcast,
//           podcastIndex: paymentBody.podcastIndex,
//         );
//         break;
//       case PurchaseType.Subscription:
//         _paytmOrder = await context.read<SubscriptionCubit>().createOrder(
//           paymentBody.amount!,
//           user.userData!.id,
//           paymentBody.subscription!.id!,
//           coupon: paymentBody.couponId,
//           upi: upi,
//         );
//         break;
//       case PurchaseType.VidyaBox:
//         _paytmOrder = await context.read<SubscriptionCubit>().createOrder(
//           paymentBody.amount!,
//           user.userData!.id,
//           paymentBody.subscription!.id!,
//           coupon: paymentBody.couponId,
//           withOrder: true,
//           className: paymentBody.preferredClass!,
//           medium: paymentBody.preferredMedium!,
//           upi: upi
//         );
//         break;
//     }
//
//     if(_paytmOrder != null && _paytmOrder.body!.txnToken != null) {
//       await AllInOneSdk.startTransaction(
//         Constants.paytmMid,
//         _paytmOrder.orderId!,
//         paymentBody.amount!.toString(),
//         _paytmOrder.body!.txnToken!,
//         "",
//         Constants.paytmIsStaging,
//         false,
//       );
//       await Future.delayed(const Duration(seconds: 2));
//       switch(purchaseType) {
//         case PurchaseType.Chapter:
//           // await context.read<SubscriptionCubit>().getChapter(paymentBody.chapterId, user.userData!.id);
//           break;
//         case PurchaseType.Subscription:
//           await context.read<SubscriptionCubit>().getSubscriptionDetails();
//           break;
//         case PurchaseType.VidyaBox:
//           await context.read<SubscriptionCubit>().getSubscriptionDetails();
//           break;
//       }
//     }
//     _loadingOverlay.hide();
//   }
// }

class Razorpay extends PaymentGateway {
  late bool _upi;

  final _razorpay = RZP.Razorpay();

  late LoadingOverlay _loadingOverlay;
  late PurchaseType purchaseType;
  late BuildContext context;
  late PaymentBody paymentBody;
  late TbUserData user;

  Razorpay({bool upi = false}) {
    _upi = upi;
    _razorpay.on(RZP.Razorpay.EVENT_PAYMENT_SUCCESS, (data) async {
      log(data.toString());
      List<dynamic> responses =
          await Future.wait([Future.delayed(const Duration(seconds: 2)), context.read<GlobalCubit>().showFailurePossibilityDialog()]);
      switch (purchaseType) {
        case PurchaseType.Chapter:
          // await context.read<SubscriptionCubit>().getChapter(paymentBody.chapterId!, user.id);
          break;
        case PurchaseType.Subscription:
          await context.read<SubscriptionCubit>().getSubscriptionDetails();
          break;
        case PurchaseType.VidyaBox:
          await context.read<SubscriptionCubit>().getSubscriptionDetails();
          break;
      }
      _loadingOverlay.hide();

      // go to thank you page...
      // AutoRouter.of(context).push(ThankYouPageRoute());
      AutoRouter.of(context).push(OrderShippingScreenRoute(userId: user.id, message: 'Order Placed', paymentId: data.razorpay_payment_id));

      //if show failure possibility is high then show the dialog...
      if (responses.last) {
        WarningAlertBox(
            title: "Warning!!!",
            messageText: "We're facing some technical issues, If you don't get a subscription, please contact to +91 9799166556",
            context: context);
      }

      UserSubscription? userSubscription = context.read<SubscriptionCubit>().state.userSubscription;
      int subscriptionDays = 0;

      if (userSubscription != null) {
        subscriptionDays = userSubscription.sub!.duration! - (DateTime.now().difference(DateTime.parse(userSubscription.createdAt!)).inDays);
      }

      if (purchaseType == PurchaseType.Subscription && (userSubscription == null && subscriptionDays <= 0)) {
        int count = 0;
        Timer.periodic(const Duration(seconds: 60), (timer) async {
          if (context.read<SubscriptionCubit>().state.userSubscription != null) {
            timer.cancel();
          }
          if (count < 3) {
            await context.read<SubscriptionCubit>().getSubscriptionDetails();
          } else {
            timer.cancel();
          }
          count++;
        });
      }
    });

    _razorpay.on(RZP.Razorpay.EVENT_PAYMENT_ERROR, (err) {
      _loadingOverlay.hide();
      // Sentry.captureException(err, hint: "Payment Gateway Page");
      log(err.toString());

      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return Scaffold(
              backgroundColor: Colors.black87,
              body: Container(
                width: 1.sw,
                height: 1.sh,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 18, bottom: 0, right: 18, left: 18),
                    margin: EdgeInsets.symmetric(horizontal: 18.sp),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Having Trouble or Doubt?",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 21.sp, fontFamily: "Montserrat-Bold"),
                        ),
                        SizedBox(
                          height: 4.sp,
                        ),
                        Text(
                          "If you have any kind of doubt or query regarding subscription please let us know!",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontSize: 14.sp,
                              ),
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  launch("tel://${Constants.mobileNumber}");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Call Now",
                                      style: TextStyle(color: Colors.white, fontFamily: "Montserrat-Bold"),
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
                            )
                          ],
                        ),
                        SizedBox(
                          height: 6.sp,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  launch(
                                      "https://wa.me/+91${Constants.mobileNumber}?text=${Uri.encodeFull("Hi SunoKitaab, I am ${(context.read<UserCubit>().state as UserLoaded).userData!.fullname}")} i am having some doubt/issues regarding the Subscription");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Boxicons.bxl_whatsapp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Whatsapp Us",
                                      style: TextStyle(color: Colors.white, fontFamily: "Montserrat-Bold"),
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
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text(
                                "No, Im Good",
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }

  Future create(BuildContext context, PurchaseType purchaseType, PaymentBody paymentBody) async {
    this.context = context;
    this.purchaseType = purchaseType;
    this.paymentBody = paymentBody;
    _loadingOverlay = LoadingOverlay(context);
    _loadingOverlay.show();

    UserLoaded user = context.read<UserCubit>().state as UserLoaded;
    this.user = user.userData!;
    dynamic _rzpOrder;
    RazorpaySubscription? _rzpSubscriptionOrder;
    log(purchaseType.toString());
    switch (purchaseType) {
      case PurchaseType.Chapter:
        _rzpOrder = await context
            .read<SubscriptionCubit>()
            .createRazorpayOrderForChapter(paymentBody.amount!, user.userData!.id, paymentBody.chapterId!, upi: _upi);
        break;
      case PurchaseType.Subscription:
        if (paymentBody.recurring ?? false) {
          _rzpSubscriptionOrder = await context.read<SubscriptionCubit>().createRazorpaySubscriptionOrder(
              paymentBody.amount!, user.userData!.id, paymentBody.subscription!.id!,
              sub_start_at: paymentBody.subscription!.sub_start_at,
              addons: paymentBody.subscription!.addons,
              total_count: paymentBody.subscription!.total_count,
              coupon: paymentBody.couponId);
        } else {
          _rzpOrder = await context.read<SubscriptionCubit>().createRazorpayOrder(
                paymentBody.amount!,
                user.userData!.id,
                paymentBody.subscription!.id!,
                upi: _upi,
                coupon: context.read<PrivateCubit>().state.currentAppliedCoupon?.id,
              );

          if (_rzpOrder is String) {
            _loadingOverlay.hide();
            DangerAlertBox(context: context, title: _rzpOrder);
          }
        }
        break;
      case PurchaseType.VidyaBox:
        {
          if (paymentBody.recurring ?? false) {
            _rzpSubscriptionOrder = await context.read<SubscriptionCubit>().createRazorpaySubscriptionOrder(
                paymentBody.amount!, user.userData!.id, paymentBody.subscription!.id!,
                vb: true,
                medium: paymentBody.preferredMedium,
                coupon: paymentBody.couponId,
                selectedClass: paymentBody.preferredClass,
                sub_start_at: paymentBody.subscription!.sub_start_at,
                addons: paymentBody.subscription!.addons);
          } else {
            _rzpOrder = await context.read<SubscriptionCubit>().createRazorpayOrder(
                paymentBody.amount!, user.userData!.id, paymentBody.subscription!.id!,
                vb: true, medium: paymentBody.preferredMedium, coupon: paymentBody.couponId, selectedClass: paymentBody.preferredClass, upi: _upi);
          }
        }
        break;
    }

    Map<String, dynamic> options;

    if (paymentBody.recurring ?? false) {
      options = {
        'key': Constants.razorpayKey,
        'amount': paymentBody.amount! * 100,
        'name': 'SunoKitaab Pvt. Ltd.',
        'subscription_id': _rzpSubscriptionOrder!.id!,
        'description': "Payment to SunoKitaab",
        'prefill': {'contact': user.userData!.phone, 'email': 'void@razorpay.com'}
      };
    } else {
      options = {
        'key': Constants.razorpayKey,
        'amount': paymentBody.amount! * 100,
        'name': 'SunoKitaab Pvt. Ltd.',
        'order_id': _rzpOrder!.id,
        'description': "Payment to SunoKitaab",
        'prefill': {'contact': user.userData!.phone, 'email': 'void@razorpay.com'}
      };

      if (_upi) {
        options.addAll({
          "config": {
            "display": {
              "hide": [
                {"method": "card"},
                {"method": "wallet"},
                {"method": "netbanking"},
                {"method": "paylater"}
              ],
            },
          }
        });
      }

      if (paymentBody.payLater ?? false) {
        options.addAll({
          "config": {
            "display": {
              "hide": [
                {"method": "card"},
                {"method": "wallet"},
                {"method": "netbanking"},
                {"method": "upi"}
              ],
            },
          }
        });
      }
    }

    log(options.toString());

    try {
      // _razorpay.open(options);
    } catch (e, stacktrace) {
      UserLoaded userLoaded = context.read<UserCubit>().state as UserLoaded;
      GetIt.I<PublicRepository>().reportCrash(
        feature: "rzp payment",
        file: "payment_gateway.dart",
        method: "create",
        user: userLoaded.userData!.id,
        stacktrace: "${e.toString()}\n${stacktrace.toString()}",
      );
    }
  }

  Future create1(BuildContext context, PurchaseType purchaseType, PaymentBody paymentBody, Map<String, dynamic> customOptions) async {
    this.context = context;
    this.purchaseType = purchaseType;
    this.paymentBody = paymentBody;
    _loadingOverlay = LoadingOverlay(context);
    _loadingOverlay.show();

    UserLoaded user = context.read<UserCubit>().state as UserLoaded;
    this.user = user.userData!;
    dynamic _rzpOrder;
    RazorpaySubscription? _rzpSubscriptionOrder;
    log(purchaseType.toString());
    switch (purchaseType) {
      case PurchaseType.Chapter:
        _rzpOrder = await context
            .read<SubscriptionCubit>()
            .createRazorpayOrderForChapter(paymentBody.amount!, user.userData!.id, paymentBody.chapterId!, upi: _upi);
        break;
      case PurchaseType.Subscription:
        if (paymentBody.recurring ?? false) {
          _rzpSubscriptionOrder = await context.read<SubscriptionCubit>().createRazorpaySubscriptionOrder(
              paymentBody.amount!, user.userData!.id, paymentBody.subscription!.id!,
              sub_start_at: paymentBody.subscription!.sub_start_at,
              addons: paymentBody.subscription!.addons,
              total_count: paymentBody.subscription!.total_count,
              coupon: paymentBody.couponId);
        } else {
          _rzpOrder = await context.read<SubscriptionCubit>().createRazorpayOrder(
                paymentBody.amount!,
                user.userData!.id,
                paymentBody.subscription!.id!,
                upi: _upi,
                coupon: context.read<PrivateCubit>().state.currentAppliedCoupon?.id,
              );

          if (_rzpOrder is String) {
            _loadingOverlay.hide();
            DangerAlertBox(context: context, title: _rzpOrder);
          }
        }
        break;
      case PurchaseType.VidyaBox:
        {
          if (paymentBody.recurring ?? false) {
            _rzpSubscriptionOrder = await context.read<SubscriptionCubit>().createRazorpaySubscriptionOrder(
                paymentBody.amount!, user.userData!.id, paymentBody.subscription!.id!,
                vb: true,
                medium: paymentBody.preferredMedium,
                coupon: paymentBody.couponId,
                selectedClass: paymentBody.preferredClass,
                sub_start_at: paymentBody.subscription!.sub_start_at,
                addons: paymentBody.subscription!.addons);
          } else {
            _rzpOrder = await context.read<SubscriptionCubit>().createRazorpayOrder(
                paymentBody.amount!, user.userData!.id, paymentBody.subscription!.id!,
                vb: true, medium: paymentBody.preferredMedium, coupon: paymentBody.couponId, selectedClass: paymentBody.preferredClass, upi: _upi);
          }
        }
        break;
    }

    Map<String, dynamic> options;

    if (paymentBody.recurring ?? false) {
      int? amount = 0;
      String? addonString = paymentBody.subscription!.addons;
      if (addonString != null && addonString.isNotEmpty) {
        var addons = jsonDecode(addonString);
        if (addons[0]["item"]["amount"] != null) {
          amount = int.tryParse(addons[0]["item"]["amount"]);
        }
      }
      amount == 0 ? amount = paymentBody.amount! * 100 : amount = amount;

      options = {
        'key': Constants.razorpayKey,
        'amount': amount,
        'subscription_id': _rzpSubscriptionOrder!.id!,
        'description': "Payment to SunoKitaab",
        'email': 'void@razorpay.com',
        'currency': 'INR',
        'contact': user.userData!.phone,
      };
    } else {
      int? discount = paymentBody.couponId != null ? context.read<PrivateCubit>().state.currentAppliedCoupon?.discountAmount : 0;

      options = {
        'key': Constants.razorpayKey,
        'amount': (paymentBody.amount! - discount!) * 100,
        'order_id': _rzpOrder!.id,
        'description': "Payment to SunoKitaab",
        'email': 'void@razorpay.com',
        'currency': 'INR',
        'contact': user.userData!.phone,
      };
    }
    options.addAll(customOptions);

    log(options.toString());

    try {
      _razorpay.submit(options);
    } catch (e, stacktrace) {
      UserLoaded userLoaded = context.read<UserCubit>().state as UserLoaded;
      GetIt.I<PublicRepository>().reportCrash(
        feature: "rzp payment",
        file: "payment_gateway.dart",
        method: "create",
        user: userLoaded.userData!.id,
        stacktrace: "${e.toString()}\n${stacktrace.toString()}",
      );
    }
  }
}
// class GooglePay extends PaymentGateway {
//   late LoadingOverlay _loadingOverlay;
//   late PurchaseType purchaseType;
//   late BuildContext context;
//   late PaymentBody paymentBody;
//   late TbUserData user;
//
//   Future<void> initSquarePayment() async {
//     await InAppPayments.setSquareApplicationId('sandbox-sq0idb-GqFft5aeor9G9C8juI5wmA');
//
//     var canUseGooglePay = false;
//     if(Platform.isAndroid) {
//       // initialize the google pay with square location id
//       // use test environment first to quick start
//       await InAppPayments.initializeGooglePay(
//           'LFTHEY0P8M6PM', google_pay_constants.environmentTest);
//       // always check if google pay supported on that device
//       // before enable google pay
//       canUseGooglePay = await InAppPayments.canUseGooglePay;
//       if(canUseGooglePay) {
//         _onStartGooglePay();
//       }
//     }
//   }
//   void _onStartGooglePay() async {
//     try {
//       await InAppPayments.requestGooglePayNonce(
//           price: '1.00',
//           currencyCode: 'USD',
//           onGooglePayNonceRequestSuccess: _onGooglePayNonceRequestSuccess,
//           onGooglePayNonceRequestFailure: _onGooglePayNonceRequestFailure,
//           onGooglePayCanceled: _onGooglePayCancel, priceStatus: google_pay_constants.totalPriceStatusFinal);
//     } on InAppPaymentsException catch(ex) {
//       // handle the failure of starting apple pay
//     }
//   }
//
//   /**
//    * Callback when successfully get the card nonce details for processig
//    * google pay sheet has been closed when this callback is invoked
//    */
//   void _onGooglePayNonceRequestSuccess(CardDetails result) async {
//     try {
//       log(result.nonce);
//       // take payment with the card nonce details
//       // you can take a charge
//       // await chargeCard(result);
//
//     } on Exception catch (ex) {
//       log(ex.toString());
//       // handle card nonce processing failure
//     }
//   }
//
//   /**
//    * Callback when google pay is canceled
//    * google pay sheet has been closed when this callback is invoked
//    */
//   void _onGooglePayCancel() {
//     // handle google pay canceled
//   }
//
//   /**
//    * Callback when failed to get the card nonce
//    * google pay sheet has been closed when this callback is invoked
//    */
//   void _onGooglePayNonceRequestFailure(ErrorInfo errorInfo) {
//     log(errorInfo.message.toString());
//   }
//
//   Future create(BuildContext context, PurchaseType purchaseType, PaymentBody paymentBody) async {
//
//
//   }
//
//
// }
