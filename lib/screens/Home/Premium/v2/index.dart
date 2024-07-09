// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:countup/countup.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/style.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:share/share.dart';
// import 'package:sunokitaab/bloc/global/global_cubit.dart';
// import 'package:sunokitaab/bloc/subscription/subscription_cubit.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sunokitaab/bloc/user/user_cubit.dart';
// import 'package:sunokitaab/data/services/models/V3Subscription.dart';
// import 'package:sunokitaab/generated/l10n.dart';
// import 'package:collection/collection.dart';
// import 'package:sunokitaab/screens/Common/fading_images.dart';
// import 'package:sunokitaab/screens/Common/loading_overlay.dart';
// import 'package:sunokitaab/screens/Home/Premium/v2/bottom_sheet.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:sunokitaab/screens/Common/payment_gateways.dart' as PG;

// class PremiumScreenV2 extends StatefulWidget {
//   const PremiumScreenV2({Key? key}) : super(key: key);

//   @override
//   _PremiumState createState() => _PremiumState();
// }

// class _PremiumState extends State<PremiumScreenV2> {
//   PremiumScreenV2BottomSheets _premiumScreenV2BottomSheets = PremiumScreenV2BottomSheets();
//   ScrollController _scrollController = ScrollController();
//   ScrollController _horizontalScrollController = ScrollController();
//   List<Package>? packages;
//   bool scrollValue = false;
//   bool rightEnd = false;
//   bool didScrollForwarded = false;

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

//     // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
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

//     _horizontalScrollController.addListener(() {
//       if(_horizontalScrollController.position.pixels >= _horizontalScrollController.position.maxScrollExtent) {
//         setState(() {
//           rightEnd = true;
//         });
//       } else {
//         setState(() {
//           rightEnd = false;
//         });
//       }

//       if(_horizontalScrollController.position.pixels > (_horizontalScrollController.position.maxScrollExtent * 0.08)) {
//         setState(() {
//           didScrollForwarded = true;
//         });
//       } else {
//         setState(() {
//           didScrollForwarded = false;
//         });
//       }
//     });
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

//   Color hexToColor(String code) {
//     return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
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
//             List<Subscription> _subscription = Platform.isAndroid ? subscriptionState.subscriptionTypes!.subscription!.where((element) => element.android! && !element.vbAvailable!).toList() : subscriptionState.subscriptionTypes!.subscription!.where((element) => element.ios! && !element.vbAvailable!).toList();
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
//                                   SvgPicture.asset(
//                                     'assets/images/active_users.svg',
//                                     width: 0.4.sw,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               padding: EdgeInsets.all(16.sp),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(18),
//                                 color: Theme.of(context).primaryColor.withOpacity(0.1)
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
//                                       fontSize: 42.sp,
//                                       fontFamily: "Montserrat-Bold"
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
//                                         AppLocalizations.of(context).ActivePaidUsers,
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
//                   SliverToBoxAdapter(
//                     child: Stack(
//                       children: [
//                         Container(
//                           height: 0.37.sh,
//                           child: ListView.builder(
//                             controller: _horizontalScrollController,
//                             itemCount: _subscription.length,
//                             scrollDirection: Axis.horizontal,
//                             physics: const BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return InkWell(
//                                 onTap: () async {
//                                   if(!_subscription[index].showCouponsPage!) {
//                                     //create mandate from razorpay...

//                                     LoadingOverlay _lo = LoadingOverlay(context);
//                                     _lo.show();

//                                     final infoDialog = await context.read<GlobalCubit>().showRecurringPaymentInfoDialog();
//                                     _lo.hide();

//                                     if(infoDialog != false && _subscription[index].addons != null) {
//                                       showCupertinoDialog(
//                                         context: context,
//                                         builder: (ctx) {
//                                           bool english = true;
//                                           return StatefulBuilder(
//                                             builder: (ctx, childSetState) {
//                                               return AlertDialog(
//                                                 elevation: 0,
//                                                 title: Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     infoDialog is String ? SizedBox() : Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Row(
//                                                           children: [
//                                                             CupertinoSwitch(
//                                                               value: english, onChanged: (val) {
//                                                               childSetState(() {
//                                                                 english = val;
//                                                               });
//                                                             }),
//                                                             SizedBox(width: 4,),
//                                                             Text(
//                                                               english ? "हिन्दी" : "English"
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         SizedBox(height: 24.sp,),
//                                                       ],
//                                                     ),
//                                                     Row(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Icon(
//                                                           Icons.info_outline_rounded,
//                                                           color: Colors.blue,
//                                                           size: 28,
//                                                         ),
//                                                         SizedBox(width: 4.sp,),
//                                                         Expanded(
//                                                           child: Text(
//                                                             english ? "Before You Pay Please Read This 👇" : "भुगतान करने से पहले कृपया इसे पढ़ें 👇",
//                                                             style: Theme.of(context).textTheme.headline5,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                                 content: Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     infoDialog is bool ? english ? RichText(
//                                                       text: TextSpan(
//                                                           children: [
//                                                             TextSpan(
//                                                               text: "When you approve your payment, you'll see the transaction limit set to ₹${_subscription[index].price}, This is just for your payment authentication and ",
//                                                               style: TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16,
//                                                                 fontFamily: "Montserrat-Regular",
//                                                               ),
//                                                             ),
//                                                             TextSpan(
//                                                               text: "we will not deduct ₹${_subscription[index].price} from your account",
//                                                               style: TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16,
//                                                                 fontFamily: "Montserrat-Bold",
//                                                               ),
//                                                             ),
//                                                             TextSpan(
//                                                               text: " , you'll only be charged after ${_subscription[index].sub_start_at} Days",
//                                                               style: TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16,
//                                                                 fontFamily: "Montserrat-Regular",
//                                                               ),
//                                                             ),
//                                                           ]
//                                                       ),
//                                                     ) : RichText(
//                                                       text: TextSpan(
//                                                           children: [
//                                                             TextSpan(
//                                                               text: "जब आप भुगतान करने के लिए यहां से आगे बढ़ेंगे, तब आपको ₹${_subscription[index].price} की भुगतान राशि स्क्रीन पर दिखाई पड़ेगी, यह केवल आपके भुगतान प्रमाणीकरण के लिए है ",
//                                                               style: TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16,
//                                                                 fontFamily: "Montserrat-Regular",
//                                                               ),
//                                                             ),
//                                                             TextSpan(
//                                                               text: "और हम आपके खाते से ₹${_subscription[index].price} नहीं काटेंगे",
//                                                               style: TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16,
//                                                                 fontFamily: "Montserrat-Bold",
//                                                               ),
//                                                             ),
//                                                             TextSpan(
//                                                               text: " आपसे केवल ${_subscription[index].sub_start_at} दिनों के बाद शुल्क लिया जाएगा",
//                                                               style: TextStyle(
//                                                                 color: Colors.black,
//                                                                 fontSize: 16,
//                                                                 fontFamily: "Montserrat-Regular",
//                                                               ),
//                                                             ),
//                                                           ]
//                                                       ),
//                                                     ) :
//                                                     Text(
//                                                       infoDialog,
//                                                       style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontSize: 16,
//                                                         fontFamily: "Montserrat-Regular",
//                                                       ),
//                                                     ),
//                                                     SizedBox(height: 12.sp,),
//                                                     Row(
//                                                       children: [
//                                                         Expanded(
//                                                           child: TextButton(
//                                                             onPressed: () async {
//                                                               Navigator.pop(ctx);
//                                                               PG.Razorpay _rzp = PG.Razorpay();
//                                                               _rzp.create(
//                                                                 context,
//                                                                 PG.PurchaseType.Subscription,
//                                                                 PG.PaymentBody(
//                                                                   subscription: _subscription[index],
//                                                                   amount: _subscription[index].price,
//                                                                   recurring: _subscription[index].recurring
//                                                                 )
//                                                               );
//                                                             },
//                                                             child: Text(
//                                                               english ? "I Understand" : "मैं समझ गया/गई",
//                                                               style: TextStyle(
//                                                                 color: Colors.white,
//                                                                 fontFamily: "Montserrat-Bold"
//                                                               ),
//                                                             ),
//                                                             style: ButtonStyle(
//                                                               shape: MaterialStateProperty.all(ContinuousRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
//                                                               backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           );
//                                         }
//                                       );
//                                     } else {
//                                       PG.Razorpay _rzp = PG.Razorpay();
//                                       _rzp.create(
//                                         context,
//                                         PG.PurchaseType.Subscription,
//                                         PG.PaymentBody(
//                                           subscription: _subscription[index],
//                                           amount: _subscription[index].price,
//                                           recurring: _subscription[index].recurring
//                                         )
//                                       );
//                                     }
//                                   } else {
//                                     _premiumScreenV2BottomSheets.showSubscriptionBottomSheet(context, _subscription[index], packages);
//                                   }
//                                 },
//                                 child: Stack(
//                                   clipBehavior: Clip.none,
//                                   children: [
//                                     Container(
//                                       width: 0.5.sw,
//                                       decoration: BoxDecoration(
//                                         border: _subscription[index].popular! ? Border.all(
//                                           color: Colors.red,
//                                           width: 2.6,
//                                         ) : null,
//                                         borderRadius: BorderRadius.circular(12.sp),
//                                         // color: Theme.of(context).cardColor,
//                                         gradient: LinearGradient(
//                                           begin: Alignment(0, 0),
//                                           end: Alignment(1.0, 2.0),
//                                           stops: [0, 0.4],
//                                           colors: [
//                                             hexToColor( _subscription[index].gradient!.split(",").first),
//                                             hexToColor( _subscription[index].gradient!.split(",").last)
//                                           ],
//                                         ),
//                                       ),
//                                       child: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.only(top: 24.sp, left: 18.sp),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 _subscription[index].cuttedOutPrice != null ? Text(
//                                                   "₹ ${_subscription[index].cuttedOutPrice}",
//                                                   style: TextStyle(
//                                                     fontSize: 16.sp,
//                                                     fontFamily: "Montserrat-Regular",
//                                                     color: Colors.white,
//                                                     decoration: TextDecoration.lineThrough
//                                                   ),
//                                                 ) : SizedBox(),
//                                                 Text(
//                                                   _subscription[index].name!,
//                                                   style: TextStyle(
//                                                     fontSize: 21.sp,
//                                                     color: Colors.white,
//                                                     fontFamily: "Montserrat-Bold",
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 8.sp,
//                                                 ),
//                                                 Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     Platform.isAndroid && _subscription[index].prefix != null && !(_subscription[index].prefix_inline ?? false) ? Text(
//                                                       _subscription[index].prefix!,
//                                                       style: TextStyle(
//                                                         fontSize: 14.sp,
//                                                         fontFamily: "Montserrat-Bold",
//                                                         color: Colors.white
//                                                       ),
//                                                     ) : SizedBox(),
//                                                     Row(
//                                                       children: [
//                                                         Platform.isAndroid && (_subscription[index].prefix_inline ?? false) && (_subscription[index].prefix != null) ? Text(
//                                                           _subscription[index].prefix!,
//                                                           style: TextStyle(
//                                                             fontSize: 14.sp,
//                                                             fontFamily: "Montserrat-Bold",
//                                                             color: Colors.white
//                                                           ),
//                                                         ) : SizedBox(),
//                                                         _subscription[index].price_text == null || Platform.isIOS ? Text(
//                                                           "₹${Platform.isAndroid ? _subscription[index].price! : _subscription[index].iosPrice!}",
//                                                           style: TextStyle(
//                                                             fontSize: 32.sp,
//                                                             fontFamily: "Montserrat-ExtraBold",
//                                                             color: Colors.white
//                                                           ),
//                                                         ) : Text(
//                                                           _subscription[index].price_text!,
//                                                           style: TextStyle(
//                                                             fontSize: 32.sp,
//                                                             fontFamily: "Montserrat-ExtraBold",
//                                                             color: Colors.white
//                                                           ),
//                                                         ),
//                                                         Platform.isAndroid && (_subscription[index].suffix_inline ?? false) && (_subscription[index].suffix != null) ? Text(
//                                                           _subscription[index].suffix!,
//                                                           style: TextStyle(
//                                                             fontSize: 14.sp,
//                                                             fontFamily: "Montserrat-Bold",
//                                                             color: Colors.white
//                                                           ),
//                                                         ) : SizedBox()
//                                                       ],
//                                                     ),
//                                                     SizedBox(height: 8,),
//                                                     Platform.isAndroid && _subscription[index].suffix != null && !(_subscription[index].suffix_inline ?? false) ? Text(
//                                                       _subscription[index].suffix!,
//                                                       style: TextStyle(
//                                                         fontSize: 14.sp,
//                                                         fontFamily: "Montserrat-Regular",
//                                                         fontStyle: FontStyle.italic,
//                                                         color: Colors.white
//                                                       ),
//                                                     ) : SizedBox(),
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                   height: 12.sp,
//                                                 ),
//                                                 _subscription[index].htmlDescription == null ? Text(
//                                                   _subscription[index].description!,
//                                                   style: TextStyle(
//                                                     fontSize: 14.sp,
//                                                     color: Colors.white,
//                                                     fontFamily: "Montserrat-Medium"
//                                                   ),
//                                                 ) : SizedBox()
//                                               ],
//                                             ),
//                                           ),
//                                           _subscription[index].htmlDescription != null ? Padding(
//                                             padding: EdgeInsets.only(left: 10.sp),
//                                             child: DefaultTextStyle.merge(
//                                               style: TextStyle(color: Colors.white),
//                                               child: Html(
//                                                 data: _subscription[index].htmlDescription!,
//                                                 style: {
//                                                   "li": Style(
//                                                       fontSize: FontSize.rem(1),
//                                                       fontFamily: "Montserrat-Regular",
//                                                       padding: EdgeInsets.only(bottom: 4),
//                                                       listStyleType: ListStyleType.DECIMAL,
//                                                       listStylePosition: ListStylePosition.OUTSIDE,
//                                                       color: Colors.white,
//                                                       fontStyle: FontStyle.italic
//                                                   ),
//                                                 },
//                                               ),
//                                             ),
//                                           ): SizedBox(),
//                                         ],
//                                       ),
//                                       margin: EdgeInsets.only(top: 18.sp, left: 6.sp, right: 6.sp),
//                                     ),
//                                     _subscription[index].popular! ? Positioned(
//                                       top: 5,
//                                       right: 20,
//                                       child: Container(
//                                         child: Text(
//                                           AppLocalizations.of(context).POPULAR,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: "Montserrat-Bold"
//                                           ),
//                                         ),
//                                         padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp),
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(50),
//                                           color: Colors.red
//                                         ),
//                                       ),
//                                     ) : SizedBox()
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: 30,
//                               height: 0.37.sh,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 gradient: LinearGradient(
//                                   begin: Alignment.centerLeft,
//                                   end: Alignment.centerRight,
//                                   stops: [0, 0.9],
//                                   colors: [didScrollForwarded ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1), Theme.of(context).scaffoldBackgroundColor.withOpacity(0.001)],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 30,
//                               height: 0.37.sh,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 gradient: LinearGradient(
//                                   end: Alignment.centerLeft,
//                                   begin: Alignment.centerRight,
//                                   stops: [0, 0.9],
//                                   colors: [rightEnd ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1) : Theme.of(context).scaffoldBackgroundColor, Theme.of(context).scaffoldBackgroundColor.withOpacity(0.001)],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     )
//                   ),
//                   SliverToBoxAdapter(
//                     child: SizedBox(
//                       height: 18.sp,
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: BlocBuilder<GlobalCubit, GlobalState>(
//                       builder: (context, state) {
//                         Subscription? _vbSubscription = Platform.isAndroid ? subscriptionState.subscriptionTypes!.subscription!.firstWhereOrNull((element) => element.android! && element.vbAvailable!) : subscriptionState.subscriptionTypes!.subscription!.firstWhereOrNull((element) => element.ios! && element.vbAvailable!);
//                         if(_vbSubscription != null) {
//                           return InkWell(
//                             onTap: () {
//                               if(_vbSubscription.disclaimerHtml != null || _vbSubscription.disclaimerDynamicWidget != null) {
//                                 _premiumScreenV2BottomSheets.showDisclaimerDialog(context, _vbSubscription, packages);
//                               } else {
//                                 _premiumScreenV2BottomSheets.showSubscriptionBottomSheetForVidyaBox(context, _vbSubscription, packages);
//                               }
//                             },
//                             child: VBSubCard(subscription: _vbSubscription),
//                           );
//                         }
//                         return SizedBox();
//                       },
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


// class VBSubCard extends StatelessWidget {
//   final Subscription subscription;

//   const VBSubCard({required this.subscription});

//   Color hexToColor(String code) {
//     return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget vb_static_image = Image.asset(
//       "assets/images/vb_transparent.png"
//     );
//     Widget card = ClipRRect(
//       child: Container(
//         width: 0.9.sw,
//         child:Padding(
//           padding: EdgeInsets.symmetric(horizontal: 21.sp, vertical: 24.sp),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 0.34.sh,
//                 child: BlocBuilder<GlobalCubit, GlobalState>(
//                   builder: (context, state) {
//                     if(state.vbImagesLoadingStatus != null) {
//                       switch(state.vbImagesLoadingStatus!) {
//                         case VBImagesLoadingStatus.initial:
//                           return vb_static_image;
//                         case VBImagesLoadingStatus.loading:
//                           return vb_static_image;
//                         case VBImagesLoadingStatus.fetched:
//                           return AbsorbPointer(
//                             child: FadingImagesSlider(
//                               textAlignment: Alignment.center,
//                               animationDuration: const Duration(milliseconds: 300),
//                               fadeInterval: const Duration(seconds: 3),
//                               images: state.vbImages!.map<Image>((e) => Image.file(e)).toList(),
//                               texts: [],
//                               autoFade: true,
//                             ),
//                           );
//                         case VBImagesLoadingStatus.error:
//                           return vb_static_image;
//                       }
//                     } else {
//                       return vb_static_image;
//                     }
//                   },
//                 ),
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 8),
//                       child: Text(
//                         subscription.name!,
//                         style: TextStyle(
//                           fontFamily: "Montserrat-Bold",
//                           color: Colors.white,
//                           fontSize: 18.sp
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Platform.isAndroid && subscription.prefix != null && !(subscription.prefix_inline ?? false) ? Text(
//                         subscription.prefix!,
//                       ) : SizedBox(),
//                       Row(
//                         children: [
//                           Platform.isAndroid && (subscription.prefix_inline ?? false) && (subscription.prefix != null) ? Text(
//                             subscription.prefix!,
//                           ) : SizedBox(),
//                           subscription.price_text == null || Platform.isIOS ? Text(
//                             "₹${Platform.isAndroid ? subscription.price! : subscription.iosPrice!}",
//                             style: TextStyle(
//                               fontFamily: "Montserrat-ExtraBold",
//                               color: Colors.white,
//                               fontSize: 26.sp
//                             ),
//                           ) : Text(
//                             subscription.price_text!,
//                             style: TextStyle(
//                               fontFamily: "Montserrat-ExtraBold",
//                               color: Colors.white,
//                               fontSize: 26.sp
//                             ),
//                           ),
//                           Platform.isAndroid && (subscription.suffix_inline ?? false) && (subscription.suffix != null) ? Text(
//                             subscription.suffix!,
//                           ) : SizedBox()
//                         ],
//                       ),
//                       Platform.isAndroid && subscription.suffix != null && !(subscription.suffix_inline ?? false) ? Text(
//                         subscription.suffix!,
//                       ) : SizedBox(),
//                     ],
//                   )
//                 ],
//               ),
//               SizedBox(height: 12.sp,),
//               Text(
//                 AppLocalizations.of(context).GetAnnualSubscription,
//                 style: TextStyle(
//                   fontFamily: "Montserrat-Regular",
//                   color: Colors.white,
//                   fontSize: 13
//                 ),
//               ),
//               SizedBox(height: 12.sp,),
//               TextButton(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       AppLocalizations.of(context).TellMore,
//                       style: TextStyle(
//                         color: hexToColor(subscription.gradient!.split(",").first).withOpacity(0.7),
//                         fontFamily: "Montserrat-Bold",
//                       ),
//                     ),
//                     Icon(
//                       Icons.chevron_right,
//                       color: hexToColor(subscription.gradient!.split(",").first),
//                       size: 18,
//                     ),
//                   ],
//                 ),
//                 onPressed: () {
//                   launch(subscription.videoLink!);
//                 },
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
//                   backgroundColor: MaterialStateProperty.all(Colors.white)
//                 ),
//               ),
//               SizedBox(height: 12.sp,),
//               subscription.offerTagline != null ? TextButton(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       subscription.offerTagline!,
//                       style: TextStyle(
//                         color: hexToColor(subscription.gradient!.split(",").last),
//                         fontFamily: "Montserrat-Bold",
//                       ),
//                     ),
//                   ],
//                 ),
//                 onPressed: () {
//                   launch(subscription.videoLink!);
//                 },
//                 style: ButtonStyle(
//                   padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 12.sp, vertical: 6.sp)),
//                   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp))),
//                   backgroundColor: MaterialStateProperty.all(Colors.white)
//                 ),
//               ) : SizedBox(),
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
//               Platform.isAndroid ? subscription.coupon!.length > 0 ? Column(
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
//               ): SizedBox() : SizedBox(),
//             ],
//           ),
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
//       borderRadius: BorderRadius.circular(18.sp),
//     );
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 4),
//       child: card,
//     );
//   }
// }