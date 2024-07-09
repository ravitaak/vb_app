import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  ConfettiController _controllerTopCenter = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    _controllerTopCenter.play();
    super.initState();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        AutoRouter.of(context).popUntilRoot();
        return Future.value(false);
      },
      child: Scaffold(
          body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.16),
                    Container(
                      height: 170.sp,
                      padding: EdgeInsets.all(35),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.credit_score_rounded,
                        color: Colors.white,
                        size: 120.sp,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                    Text(
                      "Thank You!",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 36.sp,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "Payment done Successfully",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 17.sp,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Text(
                      "Your subscription will be activated automatically. If not activated please wait for 15 minutes and restart the app.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.06),
                    Flexible(
                      child: HomeButton(
                        title: 'Home',
                        onTap: () => AutoRouter.of(context).popUntilRoot(),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.2),
                  ],
                ),
              ),
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
      )),
    );
  }
}

class HomeButton extends StatelessWidget {
  HomeButton({Key? key, this.title, this.onTap}) : super(key: key);

  final String? title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.sp,
        width: 200.sp,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
