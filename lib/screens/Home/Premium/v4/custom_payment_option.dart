import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter_customui/razorpay_flutter_customui.dart';
import 'package:vb_app/screens/Home/Common/payment_gateways.dart' as PG;
import 'package:vb_app/screens/Home/Premium/v4/card_info_model.dart';

import '../../../../bloc/private/private_cubit.dart';
import '../../../../bloc/user/user_cubit.dart';
import '../../../../data/services/models/Coupon.dart';
import '../../../../data/services/models/V3Subscription.dart';
import '../v2/bottom_sheet_pages.dart';

class CustomPaymentScreen extends StatefulWidget {
  const CustomPaymentScreen({Key? key, required this.subscription});
  final Subscription subscription;
  @override
  State<CustomPaymentScreen> createState() => _CustomPaymentScreenState();
}

class _CustomPaymentScreenState extends State<CustomPaymentScreen> {
  Map<Object?, Object?> availableUpiApps = {};

  bool showUpiApps = false;
  bool isBanksLoaded = false;
  late UserLoaded userLoaded;
  TextEditingController validityController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardholderController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  BottomSheetPages _bottomSheetPages = BottomSheetPages();
  ConfettiController _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 2));
  List<NetBankingModel>? netBankingList;
  Map<dynamic, dynamic>? paymentMethods;
  CardSystemData? _cardSystemData;
  final _formKeyCARD = GlobalKey<FormState>();
  final _formKeyUPI = GlobalKey<FormState>();
  List<WalletModel> walletList = [];
  //Focus nodes
  final FocusNode validityFocusNode = FocusNode();
  final FocusNode cvvFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();

  @override
  void initState() {
    userLoaded = context.read<UserCubit>().state as UserLoaded;
    getUpiApps();
    fetchAllPaymentMethods();
    walletList = WalletModel.createWalletList();

    super.initState();
  }

  fetchAllPaymentMethods() {
    Razorpay().getPaymentMethods().then((value) {
      paymentMethods = value;
      configureNetbanking();
    }).onError((error, stackTrace) {
      debugPrint('Error Fetching payment methods: $error');
    });
  }

  getUpiApps() async {
    final upiApps = await Razorpay().getAppsWhichSupportUpi();
    availableUpiApps = upiApps;
    setState(() {
      showUpiApps = true;
    });
  }

  configureNetbanking() async {
    netBankingList = [];
    var bankMaps = paymentMethods?['netbanking'];
    await Future.forEach(bankMaps.entries, (MapEntry element) async {
      String url = await Razorpay().getBankLogoUrl(element.key);
      netBankingList?.add(
        NetBankingModel(bankKey: element.key, bankName: element.value, logoUrl: url),
      );
    });
    setState(() {
      isBanksLoaded = true;
    });
  }

  @override
  void dispose() {
    validityController.dispose();
    cardNumberController.dispose();
    cardholderController.dispose();
    cvvController.dispose();
    upiController.dispose();
    _controllerTopCenter.dispose();
    super.dispose();
  }

  textTheme(int size, {FontWeight weight = FontWeight.normal, Color? color}) => Theme.of(context)
      .textTheme
      .bodyMedium!
      .copyWith(fontSize: size.sp, color: color ?? Theme.of(context).hintColor, fontFamily: "Montserrat-Regular", fontWeight: weight);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Pay Securely',
          style: TextStyle(
              color: Theme.of(context).hintColor, letterSpacing: 1.2, fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: "Montserrat-Regular"),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).hintColor,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              children: [
                widget.subscription.recurring!
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Builder(builder: (context) {
                          int? trailAmount;
                          if (widget.subscription.recurring ?? false) {
                            String? addonString = widget.subscription.addons;
                            if (addonString != null && addonString.isNotEmpty) {
                              var addons = jsonDecode(addonString);
                              if (addons[0]["item"]["amount"] != null) {
                                trailAmount = int.tryParse(addons[0]["item"]["amount"])! ~/ 100;
                              }
                            }
                          }
                          String timeUnit = widget.subscription.duration! > 364
                              ? "Year"
                              : widget.subscription.duration! > 29
                                  ? "Month"
                                  : "Week";
                          return Column(
                            children: [
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You choose: ", style: textTheme(13)),
                                  Text(widget.subscription.name!, style: textTheme(13, weight: FontWeight.bold)),
                                ],
                              ),
                              trailAmount != null
                                  ? Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      widget.subscription.sub_start_at! > 29
                                                          ? "First $timeUnit Amount"
                                                          : "${widget.subscription.sub_start_at} Days Trial Amount",
                                                      style: textTheme(13)),
                                                ],
                                              ),
                                              Text("₹${trailAmount}", style: textTheme(13, weight: FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Starting ${widget.subscription.sub_start_at == null ? "today" : "from " + DateFormat('dd MMMM').format(DateTime.now().add(Duration(days: widget.subscription.sub_start_at!)))}",
                                            style: textTheme(13)),
                                        (widget.subscription.sub_start_at ?? 15) > 29
                                            ? Text("for the next ${timeUnit.toLowerCase()}", style: textTheme(12))
                                            : Text("for the 1st ${timeUnit.toLowerCase()}", style: textTheme(12)),
                                      ],
                                    ),
                                    trailAmount == null
                                        ? Text("₹${widget.subscription.price}", style: textTheme(13, weight: FontWeight.bold))
                                        : Text("₹${widget.subscription.price} / $timeUnit", style: textTheme(13, weight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              // trailAmount == null
                              //     ? Padding(
                              //         padding: EdgeInsets.all(10.0),
                              //         child: Row(
                              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //           children: [
                              //             Column(
                              //               crossAxisAlignment: CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                     "From ${DateFormat('dd MMMM yyyy').format(DateTime.now().add(Duration(days: widget.subscription.duration!)))}",
                              //                     style: textTheme(13)),
                              //                 Text("2nd $timeUnit Onwards", style: textTheme(12)),
                              //               ],
                              //             ),
                              //             Text("₹${widget.subscription.price} / $timeUnit", style: textTheme(13, weight: FontWeight.bold)),
                              //           ],
                              //         ),
                              //       )
                              //     : SizedBox.shrink(),
                            ],
                          );
                        }),
                      )
                    : BlocConsumer<PrivateCubit, PrivateState>(
                        listener: (context, state) {
                          if (state.verifyCouponState == VerifyCouponState.verified) {
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            margin: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("You choose: ", style: textTheme(13)),
                                    Text(widget.subscription.name!, style: textTheme(13, weight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Starting today", style: textTheme(13)),
                                          Text("${widget.subscription.duration! > 365 ? "Forever" : "${widget.subscription.duration} Days"}",
                                              style: textTheme(12)),
                                        ],
                                      ),
                                      Text("₹${widget.subscription.price}", style: textTheme(13, weight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10, bottom: 10, left: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      state.currentAppliedCoupon == null
                                          ? SizedBox.shrink()
                                          : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Coupon Applied", style: textTheme(13)),
                                                Text("₹${state.currentAppliedCoupon!.discountAmount} OFF", style: textTheme(12)),
                                              ],
                                            ),
                                      InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) => _bottomSheetPages.applyCouponsPage(context, widget.subscription,
                                                    userLoaded.userData!.createdAt.toString().split(" ").first, _controllerTopCenter));
                                          },
                                          child: state.currentAppliedCoupon == null
                                              ? Text("Apply Coupon", style: textTheme(11, weight: FontWeight.bold, color: Colors.blue))
                                              : Text("Change Coupon", style: textTheme(11, weight: FontWeight.bold, color: Colors.blue))),
                                    ],
                                  ),
                                ),
                                // FInal Price
                                Padding(
                                  padding: EdgeInsets.only(right: 10, bottom: 10, left: 14),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Final Price", style: textTheme(13)),
                                      Text(
                                          "₹${state.currentAppliedCoupon == null ? widget.subscription.price : widget.subscription.price! - state.currentAppliedCoupon!.discountAmount!}",
                                          style: textTheme(13, weight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Text("One time payment", style: textTheme(13, weight: FontWeight.bold, color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                SizedBox(height: 10.sp),
                customDivider(context),

                //UPI
                headingWidget(name: "UPI", icon: Boxicons.bx_money),

                // OPTION
                Column(
                  children: [
                    SizedBox(height: 10.sp),
                    showUpiApps ? getAllUpiWidget() : const SizedBox.shrink(),
                    // ADD UPI ID
                    SizedBox(height: 10.sp),
                    InkWell(
                      onTap: () async {
                        bool isVpaValid = false;
                        upiController.clear();
                        await showUPISheet(context, isVpaValid);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Theme.of(context).cardColor,
                            child: Icon(Icons.add, color: Theme.of(context).hintColor),
                          ),
                          SizedBox(width: 10),
                          Text("Add UPI ID", style: textTheme(14, weight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
                // CARDS
                SizedBox(height: 10.sp),
                customDivider(context),
                headingWidget(
                    name: widget.subscription.recurring! ? "Credit Card" : "Credit / Debit Card",
                    icon: Boxicons.bxs_credit_card,
                    showSuffix: true,
                    onTap: () {
                      // CLEAR ALL
                      cardNumberController.clear();
                      validityController.clear();
                      cvvController.clear();
                      cardholderController.clear();
                      showDebitCreditSheet(context);
                    }),

                widget.subscription.recurring!
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          SizedBox(height: 10.sp),

                          customDivider(context),

                          headingWidget(name: "Buy Now Pay Later", icon: Icons.money),
                          const SizedBox(height: 4),
                          // Simple Pay
                          InkWell(
                            onTap: () {
                              var options = {
                                'method': 'paylater',
                                'provider': 'getsimpl',
                              };
                              onPaymentStart(options);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                              child: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  Container(
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Image.asset("assets/logo/simpl.jpg"),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Simpl Pay Later", style: textTheme(13, weight: FontWeight.bold)),
                                      Text(
                                        "Buy anything on the internetwith 1 tap.",
                                        style: textTheme(12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                const SizedBox(height: 15),
                widget.subscription.recurring!
                    ? SizedBox.shrink()
                    : isBanksLoaded
                        ? Column(
                            children: [
                              customDivider(context),
                              headingWidget(
                                name: "Net Banking",
                                icon: Boxicons.bxs_bank,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(height: 100.sp, child: buildBanksList()),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                widget.subscription.recurring!
                    ? SizedBox.shrink()
                    : Column(
                        children: [
                          customDivider(context),
                          headingWidget(
                            name: "Wallets",
                            icon: Boxicons.bxs_bank,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SizedBox(height: 100.sp, child: buildWalletList()),
                          ),
                        ],
                      ),
                const SizedBox(height: 40),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirection: math.pi / 2,
                maxBlastForce: 25,
                minBlastForce: 10,
                emissionFrequency: 0.05,
                numberOfParticles: 30,
                gravity: 0.5,
                maximumSize: const Size(20, 10),
                blastDirectionality: BlastDirectionality.explosive,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showDebitCreditSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Form(
                  key: _formKeyCARD,
                  child: Column(
                    children: [
                      RotatedBox(
                        quarterTurns: -1,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.grey.shade700,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.subscription.recurring! ? "Credit Card" : "Credit / Debit Card",
                        style: TextStyle(color: Theme.of(context).hintColor, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      customTextFormField(
                        controller: cardNumberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid Card Number';
                          }
                          return null;
                        },
                        maxLength: 19,
                        inputFormatters: [
                          CreditCardNumberInputFormatter(onCardSystemSelected: (CardSystemData? cardSystemData) {
                            setState(() {
                              _cardSystemData = cardSystemData;
                              log(_cardSystemData.toString());
                            });
                          })
                        ],
                        label: "CARD NUMBER",
                        hint: " Enter your 15/16 digit card number",
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: .2,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: customTextFormField(
                              controller: validityController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Invalid Validity';
                                }
                                return null;
                              },
                              inputFormatters: [
                                CreditCardExpirationDateFormatter(),
                              ],
                              maxLength: 5,
                              label: "VALIDITY",
                              hint: " MM / YY",
                              focusNode: validityFocusNode,
                              onChanged: (p0) {
                                if (p0!.length == 5) {
                                  cvvFocusNode.requestFocus();
                                }
                                return null;
                              },
                            ),
                          ),
                          Flexible(
                            child: customTextFormField(
                              controller: cvvController,
                              label: "CVV",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Invalid CVV';
                                }
                                return null;
                              },
                              hint: " ***",
                              maxLength: 4,
                              obscureText: true,
                              focusNode: cvvFocusNode,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: .2,
                      ),
                      customTextFormField(
                        controller: cardholderController,
                        maxLength: null,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the name mentioned on your Card';
                          }
                          return null;
                        },
                        label: "NAME ON CARD",
                        hint: " Add your name here",
                        keyboardType: TextInputType.name,
                        focusNode: nameFocusNode,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).canvasColor,
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        //validate
                        if (_formKeyCARD.currentState!.validate()) {
                          CardInfoModel cardInfoModel = CardInfoModel();
                          cardInfoModel.cardHolderName = cardholderController.text.trim();
                          cardInfoModel.cardNumber = cardNumberController.text.replaceAll(" ", "");
                          cardInfoModel.cvv = cvvController.text.trim();
                          cardInfoModel.expiryMonth = validityController.text.split("/")[0].trim();
                          cardInfoModel.expiryYear = validityController.text.split("/")[1].trim();

                          var options = {
                            "card[cvv]": cardInfoModel.cvv,
                            "card[expiry_month]": cardInfoModel.expiryMonth,
                            "card[expiry_year]": cardInfoModel.expiryYear,
                            "card[name]": cardInfoModel.cardHolderName,
                            "card[number]": cardInfoModel.cardNumber,
                            "method": "card"
                          };

                          log(options.toString());
                          onPaymentStart(options);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                              color: Theme.of(context).hintColor.withOpacity(.8),
                              width: .2,
                            ),
                            boxShadow: [BoxShadow(offset: Offset(0, 0), color: Theme.of(context).hintColor, blurRadius: 2)]),
                        child: const Center(
                          child: Text('Pay Securely ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showUPISheet(BuildContext context, bool isVpaValid) async {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Column(
                    children: [
                      RotatedBox(
                        quarterTurns: -1,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.grey.shade700,
                          size: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "UPI",
                        style: TextStyle(color: Theme.of(context).hintColor, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Form(
                        key: _formKeyUPI,
                        child: customTextFormField(
                          controller: upiController,
                          maxLength: null,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Error validating VPA';
                            }
                            return null;
                          },
                          label: "ENTER UPI ID",
                          hint: " mobilenumber@upi or username@bank",
                          keyboardType: TextInputType.text,
                          suffix: isVpaValid
                              ? Icon(Icons.check_circle, color: Colors.green)
                              : TextButton(
                                  child: Text('Verify ', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
                                  onPressed: () async {
                                    Map<dynamic, dynamic> isValid = await Razorpay().isValidVpa(upiController.text.trim());
                                    isVpaValid = isValid['success'];
                                    setState(() {});
                                  },
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).canvasColor,
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          //validate
                          if (_formKeyUPI.currentState!.validate()) {
                            var option = {
                              'method': 'upi',
                              'vpa': "${upiController.text.trim()}",
                              '_[flow]': 'collect',
                            };
                            if (isVpaValid) {
                              onPaymentStart(option);
                            }
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                color: Theme.of(context).hintColor.withOpacity(.8),
                                width: .2,
                              ),
                              boxShadow: [BoxShadow(offset: Offset(0, 0), color: Theme.of(context).hintColor, blurRadius: 2)]),
                          child: const Center(
                            child: Text('Pay Securely ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Divider customDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).hintColor,
      thickness: .1,
      indent: 12,
      endIndent: 12,
    );
  }

  Widget headingWidget({
    Function()? onTap,
    required String name,
    required IconData icon,
    bool showSuffix = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).hoverColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.sp),
            topRight: Radius.circular(10.sp),
            bottomLeft: Radius.circular(2.sp),
            bottomRight: Radius.circular(10.sp),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 10),
                Icon(icon, color: Colors.white),
                SizedBox(width: 10),
                Text(name, style: textTheme(15, weight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            showSuffix ? Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.white) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Future<AssetImage> isAssetAvailble(String imagePath) async {
    try {
      final bundle = DefaultAssetBundle.of(context);
      await bundle.load(imagePath);
      return AssetImage(imagePath);
    } catch (e) {
      return AssetImage("assets/logo/bhim.jpg");
    }
  }

  Widget getAllUpiWidget() {
    List<Widget> upiWidgets = [];
    for (var element in availableUpiApps.entries) {
      String name = element.value.toString().toLowerCase().replaceAll(" ", "");
      String asset = "assets/logo/$name.jpg";
      upiWidgets.add(
        FutureBuilder(
            future: isAssetAvailble(asset),
            builder: (context, snapshot) {
              return InkWell(
                onTap: () {
                  var options = {
                    'method': 'upi',
                    '_[flow]': 'intent',
                    'upi_app_package_name': element.key.toString(),
                  };
                  onPaymentStart(options);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: snapshot.data ?? AssetImage("assets/logo/bhim.jpg"),
                      ),
                      const SizedBox(width: 10),
                      Text(element.value.toString(), style: textTheme(14, weight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }),
      );
    }
    return Column(children: upiWidgets);
  }

  Widget buildBanksList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: netBankingList?.length,
      itemBuilder: (context, item) {
        return InkWell(
          onTap: () {
            var options = {
              'method': 'netbanking',
              'bank': netBankingList?[item].bankKey,
            };
            onPaymentStart(options);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(
                    netBankingList?[item].logoUrl ?? '',
                  ),
                ),
                SizedBox(height: 8.sp),
                SizedBox(
                  width: 80.sp,
                  child: Text(
                    netBankingList?[item].bankName ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme(11, weight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildWalletList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: walletList.length,
      itemBuilder: (context, item) {
        return InkWell(
          onTap: () {
            var options = {
              'method': 'wallet',
              'wallet': walletList[item].walletName,
            };
            onPaymentStart(options);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(walletList[item].logoUrl!),
                ),
                SizedBox(height: 8.sp),
                SizedBox(
                  width: 70.sp,
                  child: Text(
                    walletList[item].walletName!.toTitleCase(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme(11, weight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormField customTextFormField({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.number,
    bool obscureText = false,
    TextEditingController? controller,
    int? maxLength,
    String? errorText,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffix,
    String? Function(String?)? validator,
    String? Function(String?)? onChanged,
    FocusNode? focusNode,
  }) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      maxLength: maxLength,
      controller: controller,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        counterText: '',
        label: Text(label),
        suffix: suffix,
        errorText: errorText,
        labelStyle: TextStyle(
          color: Theme.of(context).hintColor,
          fontSize: 20,
          letterSpacing: 1.1,
        ),
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(height: 1.3, color: Theme.of(context).hintColor.withOpacity(.3)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.grey.shade700,
      style: TextStyle(color: Theme.of(context).hintColor),
      onChanged: onChanged,
      focusNode: focusNode,
    );
  }

  onPaymentStart(Map<String, dynamic> options) {
    try {
      PG.Razorpay _rzp = PG.Razorpay();
      if (widget.subscription.recurring!) {
        _rzp.create1(
          context,
          PG.PurchaseType.Subscription,
          PG.PaymentBody(subscription: widget.subscription, amount: widget.subscription.price, recurring: widget.subscription.recurring!),
          options,
        );
      } else {
        Coupon? coupon = context.read<PrivateCubit>().state.currentAppliedCoupon;
        _rzp.create1(
          context,
          PG.PurchaseType.Subscription,
          PG.PaymentBody(
              subscription: widget.subscription, amount: widget.subscription.price, recurring: widget.subscription.recurring!, couponId: coupon?.id),
          options,
        );
      }
    } on Exception catch (e) {
      log("Error $e");
    }
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
