import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vb_app/generated/l10n.dart';

class LoadingOverlay {
  late BuildContext context;
  BuildContext? _loaderContext;
  LoadingOverlay(BuildContext ctx) {
    context = ctx;
  }
  show() {
    showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          _loaderContext = context;
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 0.4.sw, // Dialog width
                height: 0.4.sw,
                decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(12.sp)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.twistingDots(
                      leftDotColor: Theme.of(context).primaryColor,
                      rightDotColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).cardColor,
                      size: 80,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(AppLocalizations.of(context).PleaseWait)
                  ],
                ),
              ),
            ),
          );
        });
  }

  hide() {
    if (_loaderContext != null) Navigator.pop(_loaderContext!);
  }

  hideForce() {
    Navigator.pop(context);
  }

  static justLoading(BuildContext context) {
    return Container(
      width: 0.4.sw, // Dialog width
      height: 0.4.sw,
      decoration: BoxDecoration(color: Theme.of(context).primaryColorLight, borderRadius: BorderRadius.circular(12.sp)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.twistingDots(
            leftDotColor: Theme.of(context).primaryColor,
            rightDotColor: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).cardColor,
            size: 80,
          ),
          SizedBox(
            height: 6,
          ),
          Text(AppLocalizations.of(context).PleaseWait)
        ],
      ),
    );
  }
}
