// import 'dart:io';
// import 'dart:math';
// import 'dart:developer' as dev;
// import 'package:confetti/confetti.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:dynamic_widget/dynamic_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
// // import 'package:flutter_contacts/contact.dart';
// // import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:get_it/get_it.dart';
// import 'package:purchases_flutter/object_wrappers.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// 
// import 'package:sunokitaab/bloc/private/private_cubit.dart';
// import 'package:sunokitaab/bloc/subscription/subscription_cubit.dart';
// import 'package:sunokitaab/bloc/user/user_cubit.dart';
// import 'package:sunokitaab/data/database/db.dart';
// import 'package:sunokitaab/data/services/models/Coupon.dart';
// import 'package:sunokitaab/data/services/models/V3Subscription.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sunokitaab/data/services/repository/MiscRepository.dart';
// import 'package:sunokitaab/generated/l10n.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:sunokitaab/routes/index.gr.dart';
// import 'package:sunokitaab/screens/Common/payment_gateways.dart' as PG;
// import 'package:sunokitaab/screens/Home/Premium/v2/bottom_sheet_pages.dart';


// class PremiumScreenV2BottomSheets {
//   late int selectedSubscription;
//   int? amount;
//   bool withOrder = false;
//   String? selectedClass = "";
//   String? selectedMedium = "";
//   Coupon? selectedCoupon;

//   showSubscriptionBottomSheet(BuildContext context, Subscription subscription, List<Package>? packages) {
//     UserLoaded userLoaded = context.read<UserCubit>().state as UserLoaded;
//     PageController _controller = PageController();
//     int currPage = 0;
//     ConfettiController _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 2));
//     BottomSheetPages _bottomSheetPages = BottomSheetPages();

//     List<Widget> _pageViewPages = [];

//     //if platform is android and subscription does not allow demo or trial
//     //then we need to show apply coupon page...

//     // dev.log((Platform.isAndroid && subscription.showCouponsPage!).toString(), name: "Platform.isAndroid && subscription.showCouponsPage!");
//     if(Platform.isAndroid && subscription.showCouponsPage!) {
//       _pageViewPages.insert(
//         0,
//         _bottomSheetPages.applyCouponsPage(context, subscription, userLoaded.userData!.createdAt.toString().split(" ").first, _controllerTopCenter),
//       );
//     }

//     if(Platform.isAndroid && !subscription.recurring! && subscription.showGatewaysPage!) {
//       _pageViewPages.add(_bottomSheetPages.paymentGatewaysPage(context, subscription, amount));
//     }

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (dialogContext, setState) {
//             return Container(
//               height: 0.7.sh,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 0.7.sh,
                
//                     padding: EdgeInsets.symmetric( vertical: 24.sp),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: PageView(
//                             controller: _controller,
//                             onPageChanged: (index) {
//                               setState(() {
//                                 currPage = index;
//                               });
//                             },
//                             children: _pageViewPages,
//                           ),
//                         ),
//                         (currPage == 0 && PG.PurchaseType != PG.PurchaseType.VidyaBox && !subscription.showCouponsPage!) || (currPage == 1 && PG.PurchaseType != PG.PurchaseType.VidyaBox) ? SizedBox() : BlocBuilder<PrivateCubit, PrivateState>(
//                           builder: (context, state) {
//                             return Row(
//                               children: [
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 18.sp),
//                                     child: TextButton(
//                                       child: Text(
//                                         currPage == 0 ? AppLocalizations.of(context).Next : "${AppLocalizations.of(context).pay} ₹${subscription.price! - (state.currentAppliedCoupon == null ? 0 : state.currentAppliedCoupon!.discountAmount != null ? state.currentAppliedCoupon!.discountAmount : (state.currentAppliedCoupon!.discountPercent * subscription.price).ceilToDouble())}",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: "Montserrat-ExtraBold",
//                                             fontSize: 18.sp
//                                         ),
//                                       ),
//                                       style: ButtonStyle(
//                                           backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
//                                           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),
//                                           padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18.sp))
//                                       ),
//                                       onPressed: () async {
//                                         int _amount = (subscription.price! - (state.currentAppliedCoupon == null ? 0 : state.currentAppliedCoupon!.discountAmount != null ? state.currentAppliedCoupon!.discountAmount : (state.currentAppliedCoupon!.discountPercent * subscription.price))).toInt();
//                                         if(Platform.isAndroid) {
//                                           if(subscription.recurring!) {
//                                             //create mandate from razorpay...
//                                             PG.Razorpay _rzp = PG.Razorpay();
//                                             _rzp.create(
//                                               context,
//                                               PG.PurchaseType.VidyaBox,
//                                               PG.PaymentBody(
//                                                 subscription: subscription,
//                                                 amount: _amount,
//                                                 recurring: subscription.recurring
//                                               )
//                                             );
//                                           } else {
//                                             _controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//                                           }
//                                         } else {
//                                           purchaseForIos(context, "sunokitaab_sub_${subscription.id}", packages!);
//                                           Navigator.pop(context);
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: ConfettiWidget(
//                       confettiController: _controllerTopCenter,
//                       blastDirection: pi / 2,
//                       maxBlastForce: 25,
//                       minBlastForce: 10,
//                       emissionFrequency: 0.05,
//                       numberOfParticles: 30,
//                       gravity: 0.5,
//                       maximumSize: const Size(20, 10),
//                       blastDirectionality: BlastDirectionality.explosive,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }
//     );
//   }

//   showDisclaimerDialog(BuildContext context, Subscription subscription, List<Package>? packages) async {
//     showCupertinoDialog(
//       context: context,
//       builder: (dialogContext) {
//         return Scaffold(
//           backgroundColor: Colors.black26,
//           body: Center(
//             child: Container(
//               padding: EdgeInsets.all(14.sp),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.sp),
//                 color: Colors.white
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 16.sp),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         AppLocalizations.of(context).Disclaimer,
//                         style: Theme.of(context).textTheme.headline3!.copyWith(
//                           fontSize: 21.sp
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12.sp,),
//                   subscription.disclaimerHtml != null ? Html(data: subscription.disclaimerHtml) : subscription.disclaimerDynamicWidget != null ? DynamicWidgetBuilder.build(subscription.disclaimerDynamicWidget!, context, DefaultClickListener())! : SizedBox(),
//                   // Spacer(),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.pop(dialogContext);
//                             showSubscriptionBottomSheetForVidyaBox(context, subscription, packages);
//                           },
//                           child: Text(
//                             AppLocalizations.of(context).Continue,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16.sp
//                             ),
//                           ),
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
//                             padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 12.sp)),
//                             shape: MaterialStateProperty.all(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)))
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
//     );
//   }

//   Future _submitDemoOrder(BuildContext context) async {
//     MiscRepository _miscRepo = GetIt.I<MiscRepository>();
//     UserLoaded _userLoaded = context.read<UserCubit>().state as UserLoaded;

//     //then submit vb order...
//     _miscRepo.createVbDemoOrder({
//       "user": _userLoaded.userData!.id,
//       "class": selectedClass,
//       "medium": selectedMedium
//     });
//     Navigator.pop(context);
//     SuccessAlertBox(
//         context: context,
//         title: "Done",
//         messageText: "Your Demo has been Booked, You'll get a phone call shortly"
//     );
//   }

//   showSubscriptionBottomSheetForVidyaBox(BuildContext context, Subscription subscription, List<Package>? packages) {
//     UserLoaded userLoaded = context.read<UserCubit>().state as UserLoaded;
//     PageController _controller = PageController();
//     String? selectedClassForVB;
//     String? selectedMediumForVB;
//     Database _database = GetIt.I<Database>();
//     int currPage = 0;
//     ConfettiController _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 2));
//     BottomSheetPages _bottomSheetPages = BottomSheetPages();

//     //Address Page...
//     Widget addressPage = StatefulBuilder(
//       builder: (context, setState) {
//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: 18.sp),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context).DetailsVidyaBox,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontFamily: "Montserrat-Bold"
//                 ),
//               ),
//               SizedBox(height: 16.sp,),
//               DropdownButton<String>(
//                 isExpanded: true,
//                 value: selectedClassForVB,
//                 hint: Text(AppLocalizations.of(context).ChooseClassVidyaBox),
//                 items: <String>[
//                   "1st",
//                   "2nd",
//                   "3rd",
//                   "4th",
//                   "5th",
//                   "6th",
//                   "8th",
//                   "9th",
//                   "10th",
//                   "11th",
//                   "12th"
//                 ].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     selectedClassForVB = val;
//                     selectedClass = val;
//                   });
//                 },
//               ),
//               SizedBox(
//                 height: 12.sp,
//               ),
//               DropdownButton<String>(
//                 isExpanded: true,
//                 value: selectedMediumForVB,
//                 hint: Text(AppLocalizations.of(context).ChooseMediumVidyaBox),
//                 items: <String>[
//                   AppLocalizations.of(context).Hindi, AppLocalizations.of(context).English
//                 ].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (val) {
//                   setState(() {
//                     selectedMediumForVB = val;
//                     selectedMedium = val;
//                   });
//                 },
//               ),
//               SizedBox(height: 12.sp),
//               StreamBuilder(
//                 stream: _database.addressDao.stream(),
//                 builder: (context, AsyncSnapshot<List<TbAddres>> snapshot) {
//                   if(snapshot.hasData) {
//                     return snapshot.data!.length == 0 ? Row(
//                       children: [
//                         Expanded(
//                             child: InkWell(
//                               child: DottedBorder(
//                                 borderType: BorderType.RRect,
//                                 radius: Radius.circular(8),
//                                 color: Theme.of(context).primaryColor,
//                                 strokeWidth: 2.6,
//                                 dashPattern: [5, 3],
//                                 child: Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 18.sp),
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           "+ ${AppLocalizations.of(context).AddShippingAddress}",
//                                           style: TextStyle(
//                                               color: Theme.of(context).primaryColor,
//                                               fontSize: 18,
//                                               fontFamily: "Montserrat-Bold"
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                 ),
//                               ),
//                               onTap: () {
//                                 context.router.push(SaveAddressScreenRoute());
//                               },
//                             )
//                         ),
//                       ],
//                     ): Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 12.sp,),
//                         Text(
//                           AppLocalizations.of(context).DeliveryAddress,
//                           style: TextStyle(
//                             fontSize: 12,
//                           ),
//                         ),
//                         SizedBox(height: 4.sp,),
//                         Text(
//                             "${snapshot.data!.first.address_line}, ${snapshot.data!.first.district.name}, ${snapshot.data!.first.state.name}, ${snapshot.data!.first.postal_code}"
//                         ),
//                         SizedBox(height: 8.sp,),
//                         Row(
//                           children: [
//                             InkWell(
//                               child: Container(
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.edit,
//                                       size: 14,
//                                       color: Colors.white,
//                                     ),
//                                     SizedBox(width: 4.sp,),
//                                     Text(
//                                       AppLocalizations.of(context).ChangeAddress,
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontFamily: "Montserrat-Bold",
//                                           fontSize: 14.sp
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
//                                 decoration: BoxDecoration(
//                                   color: Colors.blueAccent,
//                                   borderRadius: BorderRadius.circular(12.sp),
//                                 ),
//                               ),
//                               onTap: () {
//                                 context.router.push(SaveAddressScreenRoute());
//                               },
//                             ),
//                           ],
//                           mainAxisAlignment: MainAxisAlignment.end,
//                         )
//                       ],
//                     );
//                   }
//                   return SizedBox();
//                 },
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           AppLocalizations.of(context).SubTotal,
//                           style: TextStyle(
//                               fontSize: 14.sp
//                           ),
//                         ),
//                         Text(
//                           "₹${subscription.price!}",
//                           style: TextStyle(
//                               fontFamily: "Montserrat-Bold",
//                               fontSize: 16.sp
//                           ),
//                         ),
//                       ],
//                     ),
//                     BlocBuilder<PrivateCubit, PrivateState>(
//                       builder: (context, state) {
//                         return Column(
//                           children: [
//                             state.currentAppliedCoupon != null ? Column(
//                               children: [
//                                 SizedBox(height: 6.sp,),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "${AppLocalizations.of(context).Coupon} - (${state.currentAppliedCoupon!.code!})",
//                                           style: TextStyle(
//                                               fontSize: 14.sp
//                                           ),
//                                         ),
//                                         SizedBox(width: 6.sp,),
//                                         InkWell(
//                                           child: Container(
//                                             child: Text(
//                                               AppLocalizations.of(context).Remove,
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontFamily: "Montserrat-Bold",
//                                                   fontSize: 12.sp
//                                               ),
//                                             ),
//                                             padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
//                                             decoration: BoxDecoration(
//                                               color: Colors.red,
//                                               borderRadius: BorderRadius.circular(12.sp),
//                                             ),
//                                           ),
//                                           onTap: () {
//                                             context.read<PrivateCubit>().removeCoupon();
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       state.currentAppliedCoupon!.discountAmount != null ?  "- ₹${state.currentAppliedCoupon!.discountAmount}" : "${(state.currentAppliedCoupon!.discountPercent * subscription.price).ceilToDouble()}",
//                                       style: TextStyle(
//                                           fontFamily: "Montserrat-Bold",
//                                           fontSize: 16.sp,
//                                           color: Colors.blueAccent
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ): SizedBox(),
//                             SizedBox(height: 6.sp,),
//                             Divider(),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   AppLocalizations.of(context).Total,
//                                   style: TextStyle(
//                                       fontSize: 14.sp
//                                   ),
//                                 ),
//                                 Text(
//                                   "₹${subscription.price! - (state.currentAppliedCoupon == null ? 0 : state.currentAppliedCoupon!.discountAmount != null ? state.currentAppliedCoupon!.discountAmount : (state.currentAppliedCoupon!.discountPercent * subscription.price).ceilToDouble())}",
//                                   style: TextStyle(
//                                       fontFamily: "Montserrat-Bold",
//                                       fontSize: 18.sp
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         );
//                       },
//                     ),
//                     SizedBox(height: 14.sp,),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );

//     List<Widget> _pageViewPages = [
//       addressPage
//     ];

//     //if platform is android and subscription does not allow demo or trial
//     //then we need to show apply coupon page...
//     if(Platform.isAndroid && subscription.showCouponsPage!) {
//       _pageViewPages.insert(
//         0,
//         _bottomSheetPages.applyCouponsPage(context, subscription, userLoaded.userData!.createdAt.toString().split(" ").first, _controllerTopCenter),
//       );
//     }

//     if(Platform.isAndroid && !subscription.recurring! && subscription.showGatewaysPage!) {
//       _pageViewPages.add(_bottomSheetPages.paymentGatewaysPage(context, subscription, amount));
//     }

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (dialogContext, setState) {
//             return Container(
//               height: 0.7.sh,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: 0.7.sh,
//                     padding: EdgeInsets.symmetric( vertical: 24.sp),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: PageView(
//                             controller: _controller,
//                             onPageChanged: (index) {
//                               setState(() {
//                                 currPage = index;
//                               });
//                             },
//                             children: _pageViewPages,
//                           ),
//                         ),
//                         BlocBuilder<PrivateCubit, PrivateState>(
//                           builder: (context, state) {
//                             return Row(
//                               children: [
//                                 Expanded(
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 18.sp),
//                                     child: TextButton(
//                                       child: Text(
//                                         currPage == 0 ? AppLocalizations.of(context).Next : "${AppLocalizations.of(context).pay} ₹${subscription.price! - (state.currentAppliedCoupon == null ? 0 : state.currentAppliedCoupon!.discountAmount != null ? state.currentAppliedCoupon!.discountAmount : (state.currentAppliedCoupon!.discountPercent * subscription.price).ceilToDouble())}",
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: "Montserrat-ExtraBold",
//                                             fontSize: 18.sp
//                                         ),
//                                       ),
//                                       style: ButtonStyle(
//                                           backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
//                                           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),
//                                           padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18.sp))
//                                       ),
//                                       onPressed: () async {
//                                         int _amount = (subscription.price! - (state.currentAppliedCoupon == null ? 0 : state.currentAppliedCoupon!.discountAmount != null ? state.currentAppliedCoupon!.discountAmount : (state.currentAppliedCoupon!.discountPercent * subscription.price))).toInt();
//                                         if(!subscription.showGatewaysPage! && !subscription.recurring!) {
//                                           var adr = await GetIt.I<Database>().addressDao.getSingle();
//                                           if(adr != null) {
//                                             setState(() {
//                                               selectedSubscription = subscription.id!;
//                                               selectedCoupon = state.currentAppliedCoupon;
//                                               amount = _amount;
//                                               withOrder = true;
//                                             });
//                                             await _submitDemoOrder(context);
//                                             Navigator.pop(dialogContext);
//                                           }
//                                         } else if(Platform.isAndroid) {
//                                           if(currPage == 0) {
//                                             _controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//                                           } else if(currPage == 1) {
//                                             var adr = await GetIt.I<Database>().addressDao.getSingle();
//                                             if(adr != null) {
//                                               setState(() {
//                                                 selectedSubscription = subscription.id!;
//                                                 selectedCoupon = state.currentAppliedCoupon;
//                                                 amount = _amount;
//                                                 withOrder = true;
//                                               });
//                                               if(subscription.recurring!) {
//                                                 //create mandate from razorpay...
//                                                 PG.Razorpay _rzp = PG.Razorpay();
//                                                 _rzp.create(
//                                                   context,
//                                                   PG.PurchaseType.VidyaBox,
//                                                   PG.PaymentBody(
//                                                     subscription: subscription,
//                                                     amount: _amount,
//                                                     withOrder: true,
//                                                     preferredClass: selectedClassForVB,
//                                                     preferredMedium: selectedMediumForVB,
//                                                     recurring: subscription.recurring,
//                                                     couponId: selectedCoupon?.id
//                                                   )
//                                                 );
//                                               } else if(!subscription.showGatewaysPage!) {
//                                                 await _submitDemoOrder(context);
//                                                 Navigator.pop(dialogContext);
//                                               } else {
//                                                 _controller.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//                                               }
//                                             }
//                                           }
//                                         } else {
//                                           var adr = await GetIt.I<Database>().addressDao.getSingle();
//                                           if(adr != null) {
//                                             setState(() {
//                                               selectedSubscription = subscription.id!;
//                                               selectedCoupon = state.currentAppliedCoupon;
//                                               amount = _amount;
//                                               withOrder = true;
//                                             });
//                                             purchaseVidyaBoxForIos(context, "sunokitaab_sub_${subscription.id}", packages!);
//                                             Navigator.pop(context);
//                                           }
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: ConfettiWidget(
//                       confettiController: _controllerTopCenter,
//                       blastDirection: pi / 2,
//                       maxBlastForce: 25,
//                       minBlastForce: 10,
//                       emissionFrequency: 0.05,
//                       numberOfParticles: 30,
//                       gravity: 0.5,
//                       maximumSize: const Size(20, 10),
//                       blastDirectionality: BlastDirectionality.explosive,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }
//     );
//   }

//   purchaseForIos(BuildContext context, String subId, List<Package> packages) async {
//     try {
//       PurchaserInfo purchaserInfo = await Purchases.purchasePackage(packages.firstWhere((element) => element.product.identifier == subId));
//       if (purchaserInfo.entitlements.all[subId]!.isActive) {
//         BuildContext? dialogCtx;
//         showCupertinoDialog(
//           context: context,
//           builder: (context) {
//             dialogCtx = context;
//             return AlertDialog(
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(AppLocalizations.of(context).PleaseWait),
//                   SizedBox(
//                     width: 18,
//                     height: 18,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 1.8,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         );
//         await context.read<SubscriptionCubit>().saveSubscription(
//           int.parse(subId.split("_").last),
//           amount: packages.firstWhere((element) => element.product.identifier == subId).product.price,
//           ios_app_user_id: purchaserInfo.originalAppUserId,
//           success: true,
//         );

//         if(dialogCtx != null) Navigator.pop(dialogCtx!);
//       }
//     } on PlatformException catch (e, s) {
//       var errorCode = PurchasesErrorHelper.getErrorCode(e);
//       if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
//         dev.log(e.toString());
//       }

//       dev.log(e.toString());
//       // Sentry.captureException(e, stackTrace: s);
//     }
//   }

//   purchaseVidyaBoxForIos(BuildContext context, String subId, List<Package> packages) async {
//     try {
//       PurchaserInfo purchaserInfo = await Purchases.purchasePackage(packages.firstWhere((element) => element.product.identifier == subId));
//       if (purchaserInfo.entitlements.all[subId]!.isActive) {
//         BuildContext? dialogCtx;
//         showCupertinoDialog(
//             context: context,
//             builder: (context) {
//               dialogCtx = context;
//               return AlertDialog(
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(AppLocalizations.of(context).PleaseWait),
//                     SizedBox(
//                       width: 18,
//                       height: 18,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 1.8,
//                         color: Theme.of(context).primaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//         );
//         await context.read<SubscriptionCubit>().saveSubscription(
//             int.parse(subId.split("_").last),
//             amount: packages.firstWhere((element) => element.product.identifier == subId).product.price,
//             ios_app_user_id: purchaserInfo.originalAppUserId,
//             success: true,
//             kClass: selectedClass,
//             medium: selectedMedium
//         );

//         if(dialogCtx != null) Navigator.pop(dialogCtx!);
//       }
//     } on PlatformException catch (e, s) {
//       dev.log(e.toString(), stackTrace: s);

//       var errorCode = PurchasesErrorHelper.getErrorCode(e);
//       if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
//         dev.log(e.toString());
//         // Sentry.captureException(e, stackTrace: s);
//       }

//       dev.log(e.toString());
//       // Sentry.captureException(e, stackTrace: s);
//     }
//   }
// }

// class DefaultClickListener implements ClickListener{
//   @override
//   void onClicked(String? event) {
//     print("Receive click event: " + event!);
//   }
// }