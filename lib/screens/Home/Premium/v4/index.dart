import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../../bloc/global/global_cubit.dart';
import '../../../../bloc/private/private_cubit.dart';
import '../../../../bloc/subscription/subscription_cubit.dart';
import '../../../../bloc/user/user_cubit.dart';
import '../../../../data/services/models/V3Subscription.dart';
import '../../../../data/services/repository/PublicRepository.dart';
import '../../../../generated/l10n.dart';
import '../../../../routes/index.gr.dart';

// import 'package:auto_route/auto_route.dart';

class PremiumScreenV4 extends StatefulWidget {
  const PremiumScreenV4({Key? key}) : super(key: key);

  @override
  _PremiumScreenV4State createState() => _PremiumScreenV4State();
}

class _PremiumScreenV4State extends State<PremiumScreenV4> {
  @override
  void initState() {
    super.initState();

    UserLoaded _userLoaded = context.read<UserCubit>().state as UserLoaded;
    GetIt.I<PublicRepository>().sendTelegramMessagePremiumScreen(_userLoaded.userData!.fullname, _userLoaded.userData!.phone);

    context.read<GlobalCubit>().hideBadgeOnPremium();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 18.sp),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            AppLocalizations.of(context).Selectyoursubscription,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: "Montserrat-Bold"),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple.shade300, width: 2),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Topper Subscription",
                  style: TextStyle(fontSize: 12, fontFamily: 'Montserrat-Bold', color: Colors.purple.shade300),
                ),
                Divider(),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    featureBox(icon: Boxicons.bx_book_alt, text: "10000+ Books"),
                    featureBox(icon: Boxicons.bx_mobile_alt, text: "Ads Free"),
                    featureBox(icon: Boxicons.bx_pen, text: "Test Series"),
                    featureBox(icon: Boxicons.bx_command, text: "Unlock SkAI"),
                    featureBox(icon: Boxicons.bx_download, text: "Download Audio"),
                    featureBox(icon: Boxicons.bx_play_circle, text: "Background Playback"),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                MobilePlanCardBuilder()
              ],
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          SizedBox(
            height: 20.sp,
          )
        ],
      ),
    );
  }

  Widget featureBox({required String text, required IconData icon, double fontSize = 12}) {
    return SizedBox(
      width: .25.sw,
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}

class VidyaBoxContainer extends StatelessWidget {
  const VidyaBoxContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vidyabox Subscription",
            style: TextStyle(fontSize: 12, fontFamily: 'Montserrat-Bold'),
          ),
          Divider(),

          // Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: .38.sw,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).hintColor), borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [SizedBox(height: 20, width: 35, child: Image.asset('assets/images/Vidyabox.png')), Text("VidyaBox\nDevice")],
                ),
              ),
              Icon(Icons.add),
              Container(
                width: .38.sw,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(color: Theme.of(context).hintColor), borderRadius: BorderRadius.circular(16)),
                child: Row(
                  children: [
                    Icon(Boxicons.bx_mobile_alt),
                    Text(
                      "Topper\nSubscription",
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          VidyaBoxPlanCardBuilder(),
        ],
      ),
    );
  }
}

class MobilePlanCardBuilder extends StatefulWidget {
  const MobilePlanCardBuilder({Key? key}) : super(key: key);

  @override
  _MobilePlanCardBuilderState createState() => _MobilePlanCardBuilderState();
}

class _MobilePlanCardBuilderState extends State<MobilePlanCardBuilder> {
  Widget _subscriptionCard(Subscription subscription, {MainAxisSize mainAxisSize = MainAxisSize.min}) {
    int? trailAmount;
    if (subscription.recurring ?? false) {
      String? addonString = subscription.addons;
      if (addonString != null && addonString.isNotEmpty) {
        var addons = jsonDecode(addonString);
        if (addons[0]["item"]["amount"] != null) {
          trailAmount = int.tryParse(addons[0]["item"]["amount"])! ~/ 100;
        }
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (subscription.swap_title_and_duration ?? false)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subscription.name!,
                          // subscription.name!,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontSize: 18.sp,
                                fontFamily: "Montserrat-Bold",
                              ),
                        ),
                        Platform.isAndroid && (subscription.prefix != null)
                            ? Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  subscription.prefix!,
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${subscription.duration! > 365 ? "Forever" : "${subscription.duration} Days"}")
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${subscription.duration! > 365 ? "Forever" : "${subscription.duration} Days"}",
                          // subscription.name!,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontSize: 18.sp,
                                fontFamily: "Montserrat-Bold",
                              ),
                        ),
                        Platform.isAndroid && (subscription.prefix != null)
                            ? Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  subscription.prefix!,
                                  style: TextStyle(fontSize: 14.sp),
                                  overflow: TextOverflow.fade,
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          subscription.name!,
                          style: TextStyle(fontSize: 12.sp),
                        )
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  subscription.cuttedOutPrice != null
                      ? Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            trailAmount != null ? "₹${subscription.price}" : "₹${subscription.cuttedOutPrice}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 13.sp, fontFamily: "Montserrat-Regular", decoration: TextDecoration.lineThrough),
                          ),
                        )
                      : SizedBox(),
                  subscription.price_text == null || Platform.isIOS
                      ? Text(
                          Platform.isAndroid
                              ? trailAmount != null
                                  ? "₹${trailAmount}"
                                  : "₹${subscription.price}"
                              : "₹${subscription.iosPrice!}",
                          style: TextStyle(fontSize: 18.sp, fontFamily: "Montserrat-Bold", color: Theme.of(context).primaryColor),
                        )
                      : Text(
                          subscription.price_text!,
                          style: TextStyle(fontSize: 18.sp, fontFamily: "Montserrat-Bold", color: Theme.of(context).primaryColor),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          // color: (subscription.gradient?.split(",").length == 1) ? parseHexColor(subscription.gradient?.split(",").first) : Theme.of(context).cardColor,
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        switch (state.subscriptionListStatus) {
          case SubscriptionListStatus.initial:
            return SizedBox();
          case SubscriptionListStatus.loading:
            return Container(
              height: 0.6.sw,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 0.9,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(AppLocalizations.of(context).PleaseFetchingPlans)
                ],
              ),
            );
          case SubscriptionListStatus.fetched:
            List<Subscription> _subscription =
                state.subscriptionTypes!.subscription!.where((element) => !element.name!.contains("VidyaBox") && !element.vbAvailable!).toList();
            return Wrap(
                spacing: 8,
                runSpacing: 8,
                // crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    _subscription.length,
                    (index) => InkWell(
                      onTap: () {
                        context.read<PrivateCubit>().removeCoupon();
                        AutoRouter.of(context).push(CustomPaymentScreenRoute(subscription: _subscription[index]));
                      },
                      child: (_subscription[index].popular ?? false)
                          ? Stack(
                              children: [
                                _subscriptionCard(_subscription[index],
                                    mainAxisSize: _subscription.length % 2 == 0 ? MainAxisSize.min : MainAxisSize.max),
                                Positioned(
                                    right: 0,
                                    child: Container(
                                        margin: EdgeInsets.all(7),
                                        child: Icon(
                                          Boxicons.bxs_star,
                                          size: 20,
                                          color: Colors.deepOrangeAccent,
                                        ))),
                              ],
                            )
                          : _subscriptionCard(_subscription[index]),
                    ),
                  ),
                ]);
        }
      },
    );
  }
}

class VidyaBoxPlanCardBuilder extends StatefulWidget {
  const VidyaBoxPlanCardBuilder({Key? key}) : super(key: key);

  @override
  _VidyaBoxPlanCardBuilderState createState() => _VidyaBoxPlanCardBuilderState();
}

class _VidyaBoxPlanCardBuilderState extends State<VidyaBoxPlanCardBuilder> {
  Widget _subscriptionCard(Subscription subscription, {MainAxisSize mainAxisSize = MainAxisSize.max}) {
    if (subscription.recurring ?? false) {
      String? addonString = subscription.addons;
      if (addonString != null && addonString.isNotEmpty) {
        var addons = jsonDecode(addonString);
        if (addons[0]["item"]["amount"] != null) {}
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (subscription.swap_title_and_duration ?? false)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subscription.name!,
                          // subscription.name!,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontSize: 18.sp,
                                fontFamily: "Montserrat-Bold",
                              ),
                        ),
                        Platform.isAndroid && (subscription.prefix != null)
                            ? Padding(
                                padding: EdgeInsets.only(top: 4, right: 4),
                                child: Text(
                                  subscription.prefix!,
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${subscription.duration! > 365 ? "Forever" : "${subscription.duration} Days"}")
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${subscription.duration! > 365 ? "Forever" : "${subscription.duration} Days"}",
                          // subscription.name!,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontSize: 18.sp,
                                fontFamily: "Montserrat-Bold",
                              ),
                        ),
                        Platform.isAndroid && (subscription.prefix != null)
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: 4,
                                ),
                                child: Text(
                                  subscription.prefix!,
                                  style: TextStyle(fontSize: 11.sp),
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 8,
                        ),
                        Text(subscription.name!)
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  subscription.cuttedOutPrice != null
                      ? Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            "₹${subscription.cuttedOutPrice}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14.sp, fontFamily: "Montserrat-Regular", decoration: TextDecoration.lineThrough),
                          ),
                        )
                      : SizedBox(),
                  subscription.price_text == null || Platform.isIOS
                      ? Text(
                          Platform.isAndroid ? "₹${subscription.price!}" : "₹${subscription.iosPrice!}",
                          style: TextStyle(fontSize: 18.sp, fontFamily: "Montserrat-Bold", color: Theme.of(context).primaryColor),
                        )
                      : Text(
                          subscription.price_text!,
                          style: TextStyle(fontSize: 18.sp, fontFamily: "Montserrat-Bold", color: Theme.of(context).primaryColor),
                        ),
                ],
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          // color: (subscription.gradient?.split(",").length == 1) ? parseHexColor(subscription.gradient?.split(",").first) : Theme.of(context).cardColor,
          color: Theme.of(context).cardColor,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        switch (state.subscriptionListStatus) {
          case SubscriptionListStatus.initial:
            return SizedBox();
          case SubscriptionListStatus.loading:
            return Container(
              height: 0.6.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 0.9,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(AppLocalizations.of(context).PleaseFetchingPlans)
                ],
              ),
            );
          case SubscriptionListStatus.fetched:
            List<Subscription> _subscription =
                state.subscriptionTypes!.subscription!.where((element) => element.name!.contains("VidyaBox") && !element.vbAvailable!).toList();
            return Wrap(
                spacing: 8,
                runSpacing: 8,
                // crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  ...List.generate(
                    _subscription.length,
                    (index) => InkWell(
                      onTap: () {
                        context.read<PrivateCubit>().removeCoupon();
                        AutoRouter.of(context).push(CustomPaymentScreenRoute(subscription: _subscription[index]));
                      },
                      child: (_subscription[index].popular ?? false)
                          ? Stack(
                              children: [
                                _subscriptionCard(_subscription[index],
                                    mainAxisSize: _subscription.length % 2 == 0 ? MainAxisSize.min : MainAxisSize.max),
                                Positioned(
                                    right: 0,
                                    child: Container(
                                        margin: EdgeInsets.all(8),
                                        child: Icon(
                                          Boxicons.bxs_star,
                                          color: Colors.deepOrangeAccent,
                                        ))),
                              ],
                            )
                          : _subscriptionCard(_subscription[index]),
                    ),
                  ),
                ]);
        }
      },
    );
  }
}
