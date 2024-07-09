import 'package:confetti/confetti.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vb_app/bloc/private/private_cubit.dart';
import 'package:vb_app/bloc/subscription/subscription_cubit.dart';
import 'package:vb_app/data/services/models/Coupon.dart';
import 'package:vb_app/data/services/models/V3Subscription.dart';
import 'package:vb_app/generated/l10n.dart';
import 'package:vb_app/screens/Home/Common/payment_gateways.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetPages {
  Widget paymentGatewaysPage(
          BuildContext context, Subscription subscription, int? amount) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.sp),
              child: Text(
                "Choose Payment Method",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 12.sp),
              ),
            ),
            SizedBox(
              height: 8.sp,
            ),
            PaymentGateway().show(
                context,
                subscription.gateway!,
                PurchaseType.Subscription,
                PaymentBody(
                    amount: amount == null ? subscription.price : amount,
                    subscription: subscription)),
          ],
        ),
      );

  Widget applyCouponsPage(BuildContext context, Subscription subscription,
      String userCreatedAt, ConfettiController controllerTopCenter) {
    // context.read<PrivateCubit>().removeCoupon();
    TextEditingController _couponTextController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.sp),
      child: BlocConsumer<PrivateCubit, PrivateState>(
        listener: (context, state) {
          if (state.verifyCouponState == VerifyCouponState.verified) {
            controllerTopCenter.play();
            _couponTextController.text = "";
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.sp,
              ),
              //Apply Coupon Text Field...
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _couponTextController,
                      enabled: state.currentAppliedCoupon == null,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).EnterCouponCode,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.sp),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.sp),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1.6)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.sp),
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.6),
                                width: 1.6)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.sp,
                  ),
                  TextButton(
                    child: Builder(
                      builder: (context) {
                        Widget text = Text(
                          AppLocalizations.of(context).APPLY,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Montserrat-Bold",
                          ),
                        );
                        if (state.verifyCouponState != null) {
                          switch (state.verifyCouponState!) {
                            case VerifyCouponState.initial:
                              return text;
                            case VerifyCouponState.loading:
                              return SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1.6,
                                ),
                              );
                            case VerifyCouponState.verified:
                              return text;
                            case VerifyCouponState.error:
                              return text;
                          }
                        }
                        return text;
                      },
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            state.currentAppliedCoupon == null
                                ? Theme.of(context).primaryColor
                                : Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.sp))),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 20.sp, horizontal: 18.sp))),
                    onPressed: state.currentAppliedCoupon == null
                        ? () async {
                            context.read<PrivateCubit>().validateCouponCode({
                              "price": subscription.price!,
                              "sub": subscription.id,
                              "createdAt": userCreatedAt,
                              "code": _couponTextController.text
                                  .trim()
                                  .toUpperCase()
                            });
                          }
                        : null,
                  )
                ],
              ),
              state.currentAppliedCoupon == null &&
                      subscription.coupon!.length > 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12.sp,
                        ),
                        Text(
                          AppLocalizations.of(context).AvailableCoupons,
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Wrap(
                          children: List.generate(subscription.coupon!.length,
                              (index) {
                            List<Coupon> _subscriptionAssociatedCoupons =
                                context
                                    .read<SubscriptionCubit>()
                                    .state
                                    .subscriptionTypes!
                                    .coupons!
                                    .where((element) => subscription.coupon!
                                        .contains(element.id))
                                    .toList();
                            return InkWell(
                              child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(8.sp),
                                  color: Colors.black,
                                  strokeWidth: 2,
                                  dashPattern: [5, 3],
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.sp, horizontal: 12.sp),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: Text(
                                      _subscriptionAssociatedCoupons[index]
                                          .code!,
                                      style: TextStyle(
                                        fontFamily: "Montserrat-Bold",
                                      ),
                                    ),
                                  )),
                              onTap: () {
                                Coupon _coupon =
                                    _subscriptionAssociatedCoupons[index];
                                context.read<PrivateCubit>().setCoupon(_coupon);
                              },
                            );
                          }),
                        ),
                      ],
                    )
                  : SizedBox(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).SubTotal,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Text(
                          "₹${subscription.price!}",
                          style: TextStyle(
                              fontFamily: "Montserrat-Bold", fontSize: 16.sp),
                        ),
                      ],
                    ),
                    state.currentAppliedCoupon != null
                        ? Column(
                            children: [
                              SizedBox(
                                height: 6.sp,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${AppLocalizations.of(context).Coupon} - (${state.currentAppliedCoupon!.code!})",
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      SizedBox(
                                        width: 6.sp,
                                      ),
                                      InkWell(
                                        child: Container(
                                          child: Text(
                                            AppLocalizations.of(context).Remove,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Montserrat-Bold",
                                                fontSize: 12.sp),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4.sp, vertical: 2.sp),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12.sp),
                                          ),
                                        ),
                                        onTap: () {
                                          context
                                              .read<PrivateCubit>()
                                              .removeCoupon();
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.currentAppliedCoupon!
                                                .discountAmount !=
                                            null
                                        ? "- ₹${state.currentAppliedCoupon!.discountAmount}"
                                        : "${(state.currentAppliedCoupon!.discountPercent * subscription.price).ceilToDouble()}",
                                    style: TextStyle(
                                        fontFamily: "Montserrat-Bold",
                                        fontSize: 16.sp,
                                        color: Colors.blueAccent),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context).Total,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        Text(
                          "₹${subscription.price! - (state.currentAppliedCoupon == null ? 0 : state.currentAppliedCoupon!.discountAmount != null ? state.currentAppliedCoupon!.discountAmount : (state.currentAppliedCoupon!.discountPercent * subscription.price).ceilToDouble())}",
                          style: TextStyle(
                              fontFamily: "Montserrat-Bold", fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.sp,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  chapterSheet(BuildContext context, int amount, PaymentBody pb,
      List<Gateway> gateways) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              AppLocalizations.of(context).ChoosePaymentMethod,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 12.sp),
            ),
            SizedBox(
              height: 8.sp,
            ),
            PaymentGateway().show(context, gateways, PurchaseType.Chapter, pb),
          ],
        ),
      ),
    );
  }
}
