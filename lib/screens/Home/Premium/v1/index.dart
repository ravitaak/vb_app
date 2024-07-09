// import 'dart:developer' as dev;
// import 'dart:io';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:confetti/confetti.dart';
// import 'package:countup/countup.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_toastr/flutter_toastr.dart';
// import 'package:get_it/get_it.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// 
// import 'package:share/share.dart';
// import 'package:sunokitaab/bloc/global/global_cubit.dart';
// import 'package:sunokitaab/bloc/private/private_cubit.dart';
// import 'package:sunokitaab/bloc/subscription/subscription_cubit.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sunokitaab/bloc/user/user_cubit.dart';
// import 'package:sunokitaab/data/database/db.dart';
// import 'package:sunokitaab/data/services/models/Coupon.dart';
// import 'package:sunokitaab/data/services/models/PaytmOrder.dart';
// import 'package:sunokitaab/data/services/models/V3Subscription.dart';
// import 'package:sunokitaab/generated/l10n.dart';
// import 'package:sunokitaab/routes/index.gr.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:math' as math;
// import 'package:auto_route/auto_route.dart';
// import 'package:collection/collection.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class PremiumScreenV1 extends StatefulWidget {
//   const PremiumScreenV1({Key? key}) : super(key: key);

//   @override
//   _PremiumState createState() => _PremiumState();
// }

// class _PremiumState extends State<PremiumScreenV1> {
//   late int selectedSubscription;
//   late int amount;
//   bool withOrder = false;
//   String? selectedClass = "";
//   String? selectedMedium = "";
//   Coupon? selectedCoupon;
//   bool scrollValue = false;
//   ScrollController _scrollController = ScrollController();
//   late ConfettiController _controllerTopCenter;
//   List<Package>? packages;

//   paytmCreateOrder() async {
//     //show loading over screen...
//     BuildContext? _dialogContext;
//     showCupertinoDialog(
//       context: context,
//       builder: (context) {
//         _dialogContext = context;
//         return AlertDialog(
//           elevation: 0,
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children : [
//               Text(
//                 AppLocalizations.of(context).dontPressBack,
//                 style: TextStyle(
//                     fontSize: 16.sp
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//                 width: 15,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 1.5,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//     );

//     UserLoaded user = context.read<UserCubit>().state as UserLoaded;
//     PaytmOrder txnResponse = await context.read<SubscriptionCubit>().createOrder(
//         amount,
//         user.userData!.id,
//         selectedSubscription,
//         coupon: selectedCoupon?.id,
//         withOrder: withOrder,
//         medium: selectedMedium,
//         className: selectedClass
//     );

//     if(txnResponse.body != null && txnResponse.body!.txnToken != null) {
//       // await AllInOneSdk.startTransaction(
//       //   Constants.paytmMid,
//       //   txnResponse.orderId!,
//       //   amount.toString(),
//       //   txnResponse.body!.txnToken!,
//       //   "",
//       //   Constants.paytmIsStaging,
//       //   false,
//       // );
//       await Future.delayed(const Duration(seconds: 2));
//       await context.read<SubscriptionCubit>().getSubscriptionDetails();

//       //close dialog and sheet...
//       if(_dialogContext != null) Navigator.pop(_dialogContext!);
//     } else {

//       //close dialog and sheet...
//       if(_dialogContext != null) Navigator.pop(_dialogContext!);
//       // Fluttertoast.showToast(
//       //   msg: AppLocalizations.of(context).SomethingWentWrong,
//       // );
//       FlutterToastr.show(AppLocalizations.of(context).SomethingWentWrong, context
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     checkDiscountInReferenceCode();
//     if(Platform.isIOS) {
//       try {
//         Purchases.getOfferings().then((offerings) {
//           packages = offerings.getOffering("Subscriptions")?.availablePackages;

//           // if(packages != null) {
//           //   packages?.forEach((element) {
//           //     dev.log(element.offeringIdentifier, name: "offeringIdentifier");
//           //     dev.log(element.product.identifier);
//           //   });
//           // }
//         });
//       } on PlatformException catch (e) {
//         // optional error handling
//       }
//     }
//     _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 2));
//     _scrollController.addListener(() {
//       if(_scrollController.offset > 300 && !scrollValue) {
//         context.read<GlobalCubit>().togglePremiumFAB(false);
//         setState(() {
//           scrollValue = true;
//         });
//       } else if(_scrollController.offset < 50 && scrollValue) {
//         context.read<GlobalCubit>().togglePremiumFAB(true);
//         setState(() {
//           scrollValue = false;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controllerTopCenter.dispose();
//   }

//   shareLink(String link) async {
//     final ByteData bytes = await rootBundle.load('assets/images/share.jpeg');
//     final Uint8List list = bytes.buffer.asUint8List();

//     final tempDir = await getTemporaryDirectory();
//     final file = await new File('${tempDir.path}/share_image.jpg').create();
//     file.writeAsBytesSync(list);
//     Share.shareFiles([file.path], text: "${AppLocalizations.of(context).ShareText} $link");
//   }

//   checkDiscountInReferenceCode() {
//     UserLoaded userLoaded = context.read<UserCubit>().state as UserLoaded;
//     SubscriptionState subscriptionState = context.read<SubscriptionCubit>().state;
//     if(userLoaded.userData!.reference_code != null && subscriptionState.referenceCode != null && (subscriptionState.referenceCode!.discounts?.isNotEmpty ?? false)) {
//       V3Subscription? _v2Subscription = context.read<SubscriptionCubit>().state.subscriptionTypes;
//       _v2Subscription!.subscription!.forEach((sub) {
//         final _discount = subscriptionState.referenceCode!.discounts!.firstWhereOrNull((element) => element.subscription!.id == sub.id);
//         if(_discount != null) {
//           setState(() {
//             _v2Subscription.subscription!.firstWhere((element) => element.id == sub.id).setPrice(sub.price! - _discount.discountAmount!);
//           });
//         }
//       });

//       context.read<SubscriptionCubit>().setSubscriptionList(_v2Subscription);
//     }
//   }

//   showCouponSheet(BuildContext context, Subscription subscription) {
//     bool loading = false;
//     Coupon? coupon;
//     UserLoaded userLoaded = context.read<UserCubit>().state as UserLoaded;
//     Function superSetState = setState;

//     showModalBottomSheet(
//         context: context,
//         isScrollControlled: true,
//         builder: (context) {
//           return StatefulBuilder(
//             builder: (context, setState) {
//               return Container(
//                 height: 0.7.sh,
//                 child: Stack(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       height: 0.7.sh,
//                       padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 24.sp),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 12.sp,
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   enabled: coupon == null,
//                                   decoration: InputDecoration(
//                                     hintText: AppLocalizations.of(context).EnterCouponCode,
//                                     enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12.sp),
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor)
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12.sp),
//                                         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.6)
//                                     ),
//                                     disabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(12.sp),
//                                         borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.6)
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 12.sp,),
//                               TextButton(
//                                 child: loading ? SizedBox(
//                                   width: 15,
//                                   height: 15,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 1.6,
//                                   ),
//                                 ): Text(
//                                   AppLocalizations.of(context).APPLY,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: "Montserrat-Bold",
//                                   ),
//                                 ),
//                                 style: ButtonStyle(
//                                     backgroundColor: MaterialStateProperty.all(coupon == null ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.4)),
//                                     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
//                                     padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20.sp, horizontal: 18.sp))
//                                 ),
//                                 onPressed: coupon == null ? () async {
//                                   setState(() {
//                                     loading = true;
//                                   });
//                                   context.read<PrivateCubit>().validateCouponCode({ "price": subscription.price!, "sub": subscription.id, "createdAt": userLoaded.userData!.createdAt.toString().split(" ").first }).then((value) {
//                                     setState(() {
//                                       loading = false;
//                                     });
//                                     if(value is Map && value.isNotEmpty) {
//                                       setState(() {
//                                         coupon = Coupon.fromJson(value);
//                                       });
//                                       _controllerTopCenter.play();
//                                     }
//                                   }).catchError((onError) {
//                                     setState(() {
//                                       loading = false;
//                                     });
//                                   });
//                                 } : null,
//                               )
//                             ],
//                           ),
//                           coupon == null ? subscription.coupon!.length > 0 ? Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 12.sp,
//                               ),
//                               Text(
//                                 AppLocalizations.of(context).AvailableCoupons,
//                                 style: TextStyle(
//                                     fontSize: 12
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 8.sp,
//                               ),
//                               Wrap(
//                                 children: List.generate(subscription.coupon!.length, (index) => InkWell(
//                                     child: DottedBorder(
//                                       borderType: BorderType.RRect,
//                                       radius: Radius.circular(8.sp),
//                                       color: Colors.black,
//                                       strokeWidth: 2,
//                                       dashPattern: [5, 3],
//                                       child: Container(
//                                           padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(8.sp),
//                                             color: Theme.of(context).cardColor,
//                                           ),
//                                           child: Text(
//                                             context.read<SubscriptionCubit>().state.subscriptionTypes!.coupons!.firstWhere((element) => element.id == subscription.coupon![index]).code!,
//                                             style: TextStyle(
//                                               fontFamily: "Montserrat-Bold",
//                                             ),
//                                           ),
//                                         )
//                                     ),
//                                     onTap: () {
//                                       setState(() {
//                                         coupon = context.read<SubscriptionCubit>().state.subscriptionTypes!.coupons!.firstWhere((element) => element.id == subscription.coupon![index]);
//                                       });
//                                       _controllerTopCenter.play();
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ): SizedBox() : SizedBox(),
//                           Expanded(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       AppLocalizations.of(context).SubTotal,
//                                       style: TextStyle(
//                                           fontSize: 14.sp
//                                       ),
//                                     ),
//                                     Text(
//                                       "₹${subscription.price!}",
//                                       style: TextStyle(
//                                           fontFamily: "Montserrat-Bold",
//                                           fontSize: 16.sp
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 coupon != null ? Column(
//                                   children: [
//                                     SizedBox(height: 6.sp,),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "${AppLocalizations.of(context).Coupon} - (${coupon!.code!})",
//                                               style: TextStyle(
//                                                   fontSize: 14.sp
//                                               ),
//                                             ),
//                                             SizedBox(width: 6.sp,),
//                                             InkWell(
//                                               child: Container(
//                                                 child: Text(
//                                                   AppLocalizations.of(context).Remove,
//                                                   style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontFamily: "Montserrat-Bold",
//                                                       fontSize: 12.sp
//                                                   ),
//                                                 ),
//                                                 padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.red,
//                                                   borderRadius: BorderRadius.circular(12.sp),
//                                                 ),
//                                               ),
//                                               onTap: () {
//                                                 setState(() {
//                                                   coupon = null;
//                                                 });
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           coupon!.discountAmount != null ?  "- ₹${coupon!.discountAmount}" : "${(coupon!.discountPercent * subscription.price).ceilToDouble()}",
//                                           style: TextStyle(
//                                               fontFamily: "Montserrat-Bold",
//                                               fontSize: 16.sp,
//                                               color: Colors.blueAccent
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ): SizedBox(),
//                                 SizedBox(height: 6.sp,),
//                                 Divider(),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       AppLocalizations.of(context).Total,
//                                       style: TextStyle(
//                                           fontSize: 14.sp
//                                       ),
//                                     ),
//                                     Text(
//                                       "₹${subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price).ceilToDouble())}",
//                                       style: TextStyle(
//                                           fontFamily: "Montserrat-Bold",
//                                           fontSize: 18.sp
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 14.sp,),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextButton(
//                                         child: Text(
//                                           "${AppLocalizations.of(context).pay} ₹${subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price).ceilToDouble())}",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontFamily: "Montserrat-ExtraBold",
//                                               fontSize: 18.sp
//                                           ),
//                                         ),
//                                         style: ButtonStyle(
//                                             backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
//                                             shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),
//                                             padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18.sp))
//                                         ),
//                                         onPressed: () {
//                                           superSetState(() {
//                                             selectedSubscription = subscription.id!;
//                                             selectedCoupon = coupon;
//                                             amount = (subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price))).toInt();
//                                             withOrder = false;
//                                           });

//                                           Navigator.pop(context);
//                                           paytmCreateOrder();
//                                           // checkout("Buy ${subscription.name!} Subscription", userLoaded.userData!.phone);
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: ConfettiWidget(
//                         confettiController: _controllerTopCenter,
//                         blastDirection: pi / 2,
//                         maxBlastForce: 25,
//                         minBlastForce: 10,
//                         emissionFrequency: 0.05,
//                         numberOfParticles: 30,
//                         gravity: 0.5,
//                         maximumSize: const Size(20, 10),
//                         blastDirectionality: BlastDirectionality.explosive,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//     );
//   }

//   showCouponSheetForVBSubscription(BuildContext context, Subscription subscription) {
//     bool loading = false;
//     Coupon? coupon;
//     UserLoaded userLoaded = context.read<UserCubit>().state as UserLoaded;
//     PageController _controller = PageController();
//     String? selectedClassForVB;
//     String? selectedMediumForVB;
//     Database _database = GetIt.I<Database>();
//     int currPage = 0;
//     Function superSetState = setState;

//     List<Widget> _pageViewPages = [

//       //second page....
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: 18.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppLocalizations.of(context).DetailsVidyaBox,
//               style: TextStyle(
//                   fontSize: 14,
//                   fontFamily: "Montserrat-Bold"
//               ),
//             ),
//             SizedBox(height: 16.sp,),
//             DropdownButton<String>(
//               isExpanded: true,
//               value: selectedClassForVB,
//               hint: Text(AppLocalizations.of(context).ChooseClassVidyaBox),
//               items: <String>[
//                 "1st",
//                 "2nd",
//                 "3rd",
//                 "4th",
//                 "5th",
//                 "6th",
//                 "8th",
//                 "9th",
//                 "10th",
//                 "11th",
//                 "12th"
//               ].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedClassForVB = val;
//                   selectedClass = val;
//                 });
//               },
//             ),
//             SizedBox(
//               height: 12.sp,
//             ),
//             DropdownButton<String>(
//               isExpanded: true,
//               value: selectedMediumForVB,
//               hint: Text(AppLocalizations.of(context).ChooseMediumVidyaBox),
//               items: <String>[
//                 AppLocalizations.of(context).Hindi, AppLocalizations.of(context).English
//               ].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedMediumForVB = val;
//                   selectedMedium = val;
//                 });
//               },
//             ),
//             SizedBox(height: 12.sp),
//             StreamBuilder(
//               stream: _database.addressDao.stream(),
//               builder: (context, AsyncSnapshot<List<TbAddres>> snapshot) {
//                 if(snapshot.hasData) {
//                   return snapshot.data!.length == 0 ? Row(
//                     children: [
//                       Expanded(
//                           child: InkWell(
//                             child: DottedBorder(
//                               borderType: BorderType.RRect,
//                               radius: Radius.circular(8),
//                               color: Theme.of(context).primaryColor,
//                               strokeWidth: 2.6,
//                               dashPattern: [5, 3],
//                               child: Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 18.sp),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "+ ${AppLocalizations.of(context).AddShippingAddress}",
//                                         style: TextStyle(
//                                             color: Theme.of(context).primaryColor,
//                                             fontSize: 18,
//                                             fontFamily: "Montserrat-Bold"
//                                         ),
//                                       ),
//                                     ],
//                                   )
//                               ),
//                             ),
//                             onTap: () {
//                               context.router.push(SaveAddressScreenRoute());
//                             },
//                           )
//                       ),
//                     ],
//                   ): Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 12.sp,),
//                       Text(
//                         AppLocalizations.of(context).DeliveryAddress,
//                         style: TextStyle(
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(height: 4.sp,),
//                       Text(
//                           "${snapshot.data!.first.address_line}, ${snapshot.data!.first.district.name}, ${snapshot.data!.first.state.name}, ${snapshot.data!.first.postal_code}"
//                       ),
//                       SizedBox(height: 8.sp,),
//                       Row(
//                         children: [
//                           InkWell(
//                             child: Container(
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.edit,
//                                     size: 14,
//                                     color: Colors.white,
//                                   ),
//                                   SizedBox(width: 4.sp,),
//                                   Text(
//                                     AppLocalizations.of(context).ChangeAddress,
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: "Montserrat-Bold",
//                                         fontSize: 14.sp
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
//                               decoration: BoxDecoration(
//                                 color: Colors.blueAccent,
//                                 borderRadius: BorderRadius.circular(12.sp),
//                               ),
//                             ),
//                             onTap: () {
//                               context.router.push(SaveAddressScreenRoute());
//                             },
//                           ),
//                         ],
//                         mainAxisAlignment: MainAxisAlignment.end,
//                       )
//                     ],
//                   );
//                 }
//                 return SizedBox();
//               },
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         AppLocalizations.of(context).SubTotal,
//                         style: TextStyle(
//                             fontSize: 14.sp
//                         ),
//                       ),
//                       Text(
//                         "₹${subscription.price!}",
//                         style: TextStyle(
//                             fontFamily: "Montserrat-Bold",
//                             fontSize: 16.sp
//                         ),
//                       ),
//                     ],
//                   ),
//                   coupon != null ? Column(
//                     children: [
//                       SizedBox(height: 6.sp,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 "${AppLocalizations.of(context).Coupon} - (${coupon.code!})",
//                                 style: TextStyle(
//                                     fontSize: 14.sp
//                                 ),
//                               ),
//                               SizedBox(width: 6.sp,),
//                               InkWell(
//                                 child: Container(
//                                   child: Text(
//                                     AppLocalizations.of(context).Remove,
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: "Montserrat-Bold",
//                                         fontSize: 12.sp
//                                     ),
//                                   ),
//                                   padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
//                                   decoration: BoxDecoration(
//                                     color: Colors.red,
//                                     borderRadius: BorderRadius.circular(12.sp),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   setState(() {
//                                     coupon = null;
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                           Text(
//                             coupon!.discountAmount != null ?  "- ₹${coupon!.discountAmount}" : "${(coupon!.discountPercent * subscription.price).ceilToDouble()}",
//                             style: TextStyle(
//                                 fontFamily: "Montserrat-Bold",
//                                 fontSize: 16.sp,
//                                 color: Colors.blueAccent
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ): SizedBox(),
//                   SizedBox(height: 6.sp,),
//                   Divider(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         AppLocalizations.of(context).Total,
//                         style: TextStyle(
//                             fontSize: 14.sp
//                         ),
//                       ),
//                       Text(
//                         "₹${subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price).ceilToDouble())}",
//                         style: TextStyle(
//                             fontFamily: "Montserrat-Bold",
//                             fontSize: 18.sp
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 14.sp,),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ];

//     if(Platform.isAndroid) {
//       _pageViewPages.insert(
//         0,
//         Padding(
//             padding: EdgeInsets.symmetric(horizontal: 18.sp),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 12.sp,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         enabled: coupon == null,
//                         decoration: InputDecoration(
//                           hintText: AppLocalizations.of(context).EnterCouponCode,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.sp),
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor)
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.sp),
//                             borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.6)
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12.sp),
//                             borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.6)
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12.sp,),
//                     TextButton(
//                       child: loading ? SizedBox(
//                         width: 15,
//                         height: 15,
//                         child: CircularProgressIndicator(
//                           color: Colors.white,
//                           strokeWidth: 1.6,
//                         ),
//                       ): Text(
//                         AppLocalizations.of(context).APPLY,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontFamily: "Montserrat-Bold",
//                         ),
//                       ),
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(coupon == null ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.4)),
//                           shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
//                           padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 20.sp, horizontal: 18.sp))
//                       ),
//                       onPressed: coupon == null ? () async {
//                         setState(() {
//                           loading = true;
//                         });
//                         context.read<PrivateCubit>().validateCouponCode({ "price": subscription.price!, "sub": subscription.id, "createdAt": userLoaded.userData!.createdAt.toString().split(" ").first })
//                             .then((value) {
//                           setState(() {
//                             loading = false;
//                           });
//                           if(value is Map && value.isNotEmpty) {
//                             setState(() {
//                               coupon = Coupon.fromJson(value);
//                             });
//                             _controllerTopCenter.play();
//                           }
//                         }).catchError((onError){
//                           setState(() {
//                             loading = false;
//                           });
//                         });
//                       } : null,
//                     )
//                   ],
//                 ),
//                 coupon == null ? subscription.coupon!.length > 0 ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 12.sp,
//                     ),
//                     Text(
//                       AppLocalizations.of(context).AvailableCoupons,
//                       style: TextStyle(
//                         fontSize: 12
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8.sp,
//                     ),
//                     Wrap(
//                       children: List.generate(subscription.coupon!.length, (index) => InkWell(
//                         child: DottedBorder(
//                             borderType: BorderType.RRect,
//                             radius: Radius.circular(8.sp),
//                             color: Colors.black,
//                             strokeWidth: 2,
//                             dashPattern: [5, 3],
//                             child: Container(
//                               padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.sp),
//                                 color: Theme.of(context).cardColor,
//                               ),
//                               child: Text(
//                                 context.read<SubscriptionCubit>().state.subscriptionTypes!.coupons!.firstWhere((element) => element.id == subscription.coupon![index]).code!,
//                                 style: TextStyle(
//                                   fontFamily: "Montserrat-Bold",
//                                 ),
//                               ),
//                             )
//                           ),
//                           onTap: () {
//                             setState(() {
//                               coupon = context.read<SubscriptionCubit>().state.subscriptionTypes!.coupons!.firstWhere((element) => element.id == subscription.coupon![index]);
//                             });
//                             _controllerTopCenter.play();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ): SizedBox() : SizedBox(),
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             AppLocalizations.of(context).SubTotal,
//                             style: TextStyle(
//                                 fontSize: 14.sp
//                             ),
//                           ),
//                           Text(
//                             "₹${subscription.price!}",
//                             style: TextStyle(
//                                 fontFamily: "Montserrat-Bold",
//                                 fontSize: 16.sp
//                             ),
//                           ),
//                         ],
//                       ),
//                       coupon != null ? Column(
//                         children: [
//                           SizedBox(height: 6.sp,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "${AppLocalizations.of(context).Coupon} - (${coupon!.code!})",
//                                     style: TextStyle(
//                                         fontSize: 14.sp
//                                     ),
//                                   ),
//                                   SizedBox(width: 6.sp,),
//                                   InkWell(
//                                     child: Container(
//                                       child: Text(
//                                         AppLocalizations.of(context).Remove,
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: "Montserrat-Bold",
//                                             fontSize: 12.sp
//                                         ),
//                                       ),
//                                       padding: EdgeInsets.symmetric(horizontal: 4.sp, vertical: 2.sp),
//                                       decoration: BoxDecoration(
//                                         color: Colors.red,
//                                         borderRadius: BorderRadius.circular(12.sp),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       setState(() {
//                                         coupon = null;
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 coupon!.discountAmount != null ?  "- ₹${coupon!.discountAmount}" : "${(coupon!.discountPercent * subscription.price).ceilToDouble()}",
//                                 style: TextStyle(
//                                     fontFamily: "Montserrat-Bold",
//                                     fontSize: 16.sp,
//                                     color: Colors.blueAccent
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ): SizedBox(),
//                       SizedBox(height: 6.sp,),
//                       Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             AppLocalizations.of(context).Total,
//                             style: TextStyle(
//                                 fontSize: 14.sp
//                             ),
//                           ),
//                           Text(
//                             "₹${subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price).ceilToDouble())}",
//                             style: TextStyle(
//                                 fontFamily: "Montserrat-Bold",
//                                 fontSize: 18.sp
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 14.sp,),

//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       );
//     }

//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Container(
//               height: 0.7.sh,
//               child: Stack(
//                 children: [
//                   Container(
//                     color: Colors.white,
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
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 18.sp),
//                                 child: TextButton(
//                                   child: Text(
//                                     currPage == 0
//                                         ? AppLocalizations.of(context).Next
//                                         : "${AppLocalizations.of(context).pay} ₹${subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price).ceilToDouble())}",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontFamily: "Montserrat-ExtraBold",
//                                         fontSize: 18.sp
//                                     ),
//                                   ),
//                                   style: ButtonStyle(
//                                       backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
//                                       shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.sp))),
//                                       padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 18.sp))
//                                   ),
//                                   onPressed: () async {
//                                     if(Platform.isAndroid) {
//                                       if(currPage == 0) {
//                                         _controller.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
//                                       } else {
//                                         var adr = await GetIt.I<Database>().addressDao.getSingle();
//                                         if(adr != null) {
//                                           superSetState(() {
//                                             selectedSubscription = subscription.id!;
//                                             selectedCoupon = coupon;
//                                             amount = (subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price))).toInt();
//                                             withOrder = true;
//                                           });
//                                           Navigator.pop(context);
//                                           paytmCreateOrder();
//                                           // checkout("Buy ${subscription.name}", userLoaded.userData!.phone);
//                                         }
//                                       }
//                                     } else {
//                                       var adr = await GetIt.I<Database>().addressDao.getSingle();
//                                       if(adr != null) {
//                                         superSetState(() {
//                                           selectedSubscription = subscription.id!;
//                                           selectedCoupon = coupon;
//                                           amount = (subscription.price! - (coupon == null ? 0 : coupon!.discountAmount != null ? coupon!.discountAmount : (coupon!.discountPercent * subscription.price))).toInt();
//                                           withOrder = true;
//                                         });
//                                         Navigator.pop(context);
//                                         buyVBSubscriptionIOS("sunokitaab_sub_${subscription.id}");
//                                       }
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
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

//   buySubscriptionIOS(String subId) async {
//     try {
//       PurchaserInfo purchaserInfo = await Purchases.purchasePackage(packages!.firstWhere((element) => element.product.identifier == subId));
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
//                   Text("Please wait"),
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
//           amount: packages!.firstWhere((element) => element.product.identifier == subId).product.price,
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

//   buyVBSubscriptionIOS(String subId) async {
//     try {
//       PurchaserInfo purchaserInfo = await Purchases.purchasePackage(packages!.firstWhere((element) => element.product.identifier == subId));
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
//                   Text("Please wait"),
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
//           amount: packages!.firstWhere((element) => element.product.identifier == subId).product.price,
//           ios_app_user_id: purchaserInfo.originalAppUserId,
//           success: true,
//           kClass: selectedClass,
//           medium: selectedMedium
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

//   @override
//   Widget build(BuildContext context) {
//     SubscriptionState subscriptionState = context.watch<SubscriptionCubit>().state;
//     return Builder(
//       builder: (context) {
//         switch(subscriptionState.subscriptionListStatus) {
//           case SubscriptionListStatus.initial:
//             return SizedBox();
//           case SubscriptionListStatus.loading:
//             return Container(
//               height: 0.6.sw,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 20,
//                     height: 20,
//                     child: CircularProgressIndicator(
//                       color: Theme.of(context).primaryColor,
//                       strokeWidth: 0.9,
//                     ),
//                   ),
//                   SizedBox(height: 8,),
//                   Text(AppLocalizations.of(context).PleaseFetchingPlans)
//                 ],
//               ),
//             );
//           case SubscriptionListStatus.fetched:
//             List<Subscription> _subscription = Platform.isAndroid ? subscriptionState.subscriptionTypes!.subscription!.where((element) => element.android!).toList() : subscriptionState.subscriptionTypes!.subscription!.where((element) => element.ios!).toList();
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 12.sp),
//               child: CustomScrollView(
//                 controller: _scrollController,
//                 physics: const BouncingScrollPhysics(),
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: BlocBuilder<GlobalCubit, GlobalState>(
//                       builder: (context, state) {
//                         if(state.marketingAssets != null && state.marketingAssets!.isNotEmpty) {
//                           if(state.marketingAssets!.firstWhere((element) => element.keyName == "PREMIUM_SCREEN_BANNER").value != null) {
//                             return Container(
//                               width: 1.sw,
//                               height: 0.16.sh,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.all(Radius.circular(12)),
//                                 color: Colors.green.withOpacity(0.2),
//                                 border: Border.all(
//                                   color: Theme.of(context).primaryColor
//                                 )
//                               ),
//                               child: CachedNetworkImage(
//                                 imageUrl: state.marketingAssets!.firstWhere((element) => element.keyName == "PREMIUM_SCREEN_BANNER").value,
//                                 imageBuilder: (context, imageProvider) => Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.all(Radius.circular(12)),
//                                     image: DecorationImage(
//                                       image: imageProvider,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 placeholder: (context, url) => Container(
//                                   child: Center(
//                                     child: CircularProgressIndicator(
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                                   ),
//                                 ),
//                                 errorWidget: (context, url, error) => Icon(Icons.error),
//                               ),
//                             );
//                           } else if(state.marketingAssets!.firstWhere((element) => element.keyName == "PREMIUM_SCREEN_VIDEO_CODE").value != null) {
//                             return ClipRRect(
//                               borderRadius: BorderRadius.circular(18),
//                               child: Container(
//                                 width: 0.9.sw,
//                                 child: YoutubePlayer(
//                                   controller: YoutubePlayerController(initialVideoId: state.marketingAssets!.firstWhere((element) => element.keyName == "PREMIUM_SCREEN_VIDEO_CODE").value),
//                                   showVideoProgressIndicator: true,
//                                 ),
//                               ),
//                             );
//                           }
//                         }
//                         return Stack(
//                           children: [
//                             Container(
//                               width: 1.sw,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   // SvgPicture.asset(
//                                   //   'assets/images/active_users.svg',
//                                   //   width: 0.4.sw,
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(16.sp),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(18),
//                                   color: Theme.of(context).primaryColor.withOpacity(0.1)
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Countup(
//                                     begin: 0,
//                                     end: 10000,
//                                     duration: Duration(seconds: 3),
//                                     separator: ',',
//                                     style: TextStyle(
//                                         fontSize: 42.sp,
//                                         fontFamily: "Montserrat-Bold"
//                                     ),
//                                   ),
//                                   SizedBox(height: 6.sp,),
//                                   Row(
//                                     children: [
//                                       Icon(
//                                         Icons.group,
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                       SizedBox(width: 8,),
//                                       Text(
//                                         "Active Paid Users",
//                                         style: TextStyle(
//                                           fontSize: 18.sp,
//                                           fontFamily: "Montserrat-Medium",
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: SizedBox(height: 6.sp,),
//                   ),
//                   ...List.generate(_subscription.length, (index) =>
//                     SliverToBoxAdapter(
//                       child: _subscription[index].vbAvailable! ?
//                       InkWell(
//                         onTap: () {
//                           showCouponSheetForVBSubscription(context, _subscription[index]);
//                         },
//                         child: VBSubCard(subscription: _subscription[index]),
//                       ) :
//                       InkWell(
//                         onTap: () {
//                           if(Platform.isAndroid) {
//                             showCouponSheet(context, _subscription[index]);
//                           } else {
//                             buySubscriptionIOS("sunokitaab_sub_${_subscription[index].id}");
//                           }
//                         },
//                         child: SubCard(subscription: _subscription[index]),
//                       ),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: SizedBox(
//                       height: 8.sp,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//         }
//       },
//     );
//   }
// }


// class SubCard extends StatelessWidget {
//   final Subscription subscription;

//   const SubCard({required this.subscription});

//   Color hexToColor(String code) {
//     return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget card = Container(
//       width: 0.9.sw,
//       margin: EdgeInsets.symmetric(vertical: 4.sp),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 8),
//                   child: Text(
//                     subscription.name!,
//                     style: TextStyle(
//                       fontFamily: "Montserrat-Bold",
//                       color: Colors.white,
//                       fontSize: 18.sp
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 "${AppLocalizations.of(context).For} ₹${Platform.isAndroid ? subscription.price! : subscription.iosPrice!}",
//                 style: TextStyle(
//                   fontFamily: "Montserrat-ExtraBold",
//                   color: Colors.white,
//                   fontSize: 26.sp
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.sp,),
//           Text(
//             subscription.description!,
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 13
//             ),
//           ),
//           SizedBox(height: 12.sp,),
//           subscription.offerTagline != null ? Text(
//             subscription.offerTagline!,
//             style: TextStyle(
//               color: Colors.white,
//               fontFamily: "Montserrat-Bold",
//             ),
//           ) : SizedBox(),
//           SizedBox(height: 12.sp,),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () {
//                   launch("https://www.sunokitaab.com/terms-and-conditions");
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white24,
//                       borderRadius: BorderRadius.circular(12)
//                   ),
//                   padding: EdgeInsets.all(6),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                           Icons.info,
//                           color: Colors.white,
//                           size: 16
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Text(
//                         AppLocalizations.of(context).TermsConditionApply,
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 10,
//                             fontFamily: "Montserrat-Bold"
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               subscription.coupon!.length > 0 ? Column(
//                 children: [
//                   SizedBox(height: 42.sp,),
//                   Row(
//                     children: [
//                       DottedBorder(
//                         borderType: BorderType.RRect,
//                         radius: Radius.circular(8),
//                         color: Colors.white,
//                         strokeWidth: 2,
//                         dashPattern: [5, 3],
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 12.sp),
//                           child: Text(
//                             context.read<SubscriptionCubit>().state.subscriptionTypes!.coupons!.firstWhere((element) => element.id == subscription.coupon!.first).code!.toUpperCase(),
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 21,
//                                 fontFamily: "Montserrat-Bold"
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12.sp,),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).ApplyCouponDiscount,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ): SizedBox(),
//             ],
//           ),
//         ],
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(18),
//         gradient: LinearGradient(
//           begin: Alignment(0, 1.6),
//           end: Alignment(1.0, -1.0),
//           stops: [0, 0.7],
//           colors: [
//             hexToColor(subscription.gradient!.split(",").first),
//             hexToColor(subscription.gradient!.split(",").last)
//           ],
//         ),
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 21.sp, vertical: 24.sp),
//     );
//     return card;
//   }
// }

// class VBSubCard extends StatelessWidget {
//   final Subscription subscription;

//   const VBSubCard({required this.subscription});

//   int calculateNumber(int number, int closest) {
//     int a = number % closest;

//     if (a > 0) {
//       return (number ~/ closest) * closest + closest;
//     }

//     return number;
//   }

//   Color hexToColor(String code) {
//     return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget card = ClipRRect(
//       child: Container(
//         width: 0.9.sw,
//         child: Stack(
//           children: [
//             Positioned(
//               right: -230,
//               left: 0,
//               bottom: 30,
//               child: Transform.rotate(
//                 child: Image.asset(
//                   'assets/images/vb_transparent.png',
//                   height: 0.4.sw,
//                 ),
//                 angle: 15 * math.pi / 180,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 21.sp, vertical: 24.sp),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(top: 8),
//                           child: Text(
//                             subscription.name!,
//                             style: TextStyle(
//                                 fontFamily: "Montserrat-Bold",
//                                 color: Colors.white,
//                                 fontSize: 18.sp
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(
//                         "${AppLocalizations.of(context).For} ₹${Platform.isAndroid ? subscription.price! : subscription.iosPrice!}",
//                         style: TextStyle(
//                             fontFamily: "Montserrat-ExtraBold",
//                             color: Colors.white,
//                             fontSize: 26.sp
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 12.sp,),
//                   Text(
//                     AppLocalizations.of(context).GetAnnualSubscription,
//                     style: TextStyle(
//                         fontFamily: "Montserrat-Regular",
//                         color: Colors.white,
//                         fontSize: 13
//                     ),
//                   ),
//                   SizedBox(height: 12.sp,),
//                   TextButton(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           AppLocalizations.of(context).TellMore,
//                           style: TextStyle(
//                             color: hexToColor(subscription.gradient!.split(",").first),
//                             fontFamily: "Montserrat-Bold",
//                           ),
//                         ),
//                         Icon(
//                           Icons.chevron_right,
//                           color: hexToColor(subscription.gradient!.split(",").first),
//                           size: 18,
//                         ),
//                       ],
//                     ),
//                     onPressed: () {
//                       launch(subscription.videoLink!);
//                     },
//                     style: ButtonStyle(
//                         padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
//                         backgroundColor: MaterialStateProperty.all(Colors.white)
//                     ),
//                   ),
//                   SizedBox(height: 12.sp,),
//                   subscription.offerTagline != null ? TextButton(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           subscription.offerTagline!,
//                           style: TextStyle(
//                             color: hexToColor(subscription.gradient!.split(",").first),
//                             fontFamily: "Montserrat-Bold",
//                           ),
//                         ),
//                       ],
//                     ),
//                     onPressed: () {
//                       // launch(subscription.videoLink!);
//                     },
//                     style: ButtonStyle(
//                         padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp)),
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
//                         backgroundColor: MaterialStateProperty.all(Colors.white)
//                     ),
//                   ) : SizedBox(),
//                   InkWell(
//                     onTap: () {
//                       launch("https://www.sunokitaab.com/terms-and-conditions");
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white24,
//                           borderRadius: BorderRadius.circular(12)
//                       ),
//                       padding: EdgeInsets.all(6),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                               Icons.info,
//                               color: Colors.white,
//                               size: 16
//                           ),
//                           SizedBox(
//                             width: 4,
//                           ),
//                           Text(
//                             AppLocalizations.of(context).TermsConditionApply,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 10,
//                                 fontFamily: "Montserrat-Bold"
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Platform.isAndroid ? subscription.coupon!.length > 0 ? Column(
//                     children: [
//                       SizedBox(height: 42.sp,),
//                       Row(
//                         children: [
//                           DottedBorder(
//                             borderType: BorderType.RRect,
//                             radius: Radius.circular(8),
//                             color: Colors.white,
//                             strokeWidth: 2,
//                             dashPattern: [5, 3],
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 12.sp),
//                               child: Text(
//                                 context.read<SubscriptionCubit>().state.subscriptionTypes!.coupons!.firstWhere((element) => element.id == subscription.coupon!.first).code!.toUpperCase(),
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 21,
//                                     fontFamily: "Montserrat-Bold"
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 12.sp,),
//                           Expanded(
//                             child: Text(
//                               AppLocalizations.of(context).ApplyCouponDiscount,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ): SizedBox() : SizedBox(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             end: Alignment(1.6, 1.2),
//             begin: Alignment(-1.0, -2.8),
//             stops: [0, 0.7],
//             colors: [hexToColor(subscription.gradient!.split(",").first), hexToColor(subscription.gradient!.split(",").last)],
//           ),
//         ),
//       ),
//       borderRadius: BorderRadius.circular(18),
//     );
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: card,
//     );
//   }
// }