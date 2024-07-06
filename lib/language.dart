import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vb_app/app.dart';
import 'package:vb_app/routes/index.gr.dart';
import 'package:vb_app/utils/ScreenUtil.dart';
import 'package:vb_app/utils/SecureStorage.dart';

import 'data/services/Constants.dart';

class LanguageScreen extends StatefulWidget {
  final bool hasUserData;
  final bool hasToken;
  LanguageScreen(this.hasUserData, this.hasToken);
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool chooseButton = false;
  String chooseLang = "";
  String langCode = "";

  @override
  Widget build(BuildContext context) {
    Sizing.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 8.sp),
        child: InkWell(
          onTap: () async {
            await SecureStorage.setValue(key: "LANG_SELECTED", value: langCode);
            App.setLocale(context, Locale(langCode));

            if (!widget.hasUserData && widget.hasToken) {
              context.router.pushAndPopUntil(SignUpScreenRoute(), predicate: (Route<dynamic> route) => false);
            } else {
              context.router.pushAndPopUntil(HomeWrapperRoute(), predicate: (Route<dynamic> route) => false);
            }
          },
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Choose",
                  style: TextStyle(color: Colors.white, fontFamily: "Montserrat-Medium", fontSize: 15),
                ),
                SizedBox(
                  width: 4.sp,
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )
              ],
            ),
            decoration: BoxDecoration(
                color: chooseButton ? Theme.of(context).primaryColor : Colors.black.withOpacity(0.14), borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Choose Language",
                  style: TextStyle(color: Colors.black, fontFamily: "Montserrat-Bold", fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "भाषा चुनें",
                  style: TextStyle(color: Colors.black, fontFamily: "Montserrat-Regular", fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 40.sp,
                ),
                GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 14.sp, mainAxisSpacing: 14.sp, childAspectRatio: 1.sp),
                    itemCount: languageList.length,
                    itemBuilder: (context, index) {
                      return languageCardWidget(
                        model: languageList[index],
                        value: chooseLang == languageList[index].mainText ? true : false,
                        function: () {
                          setState(() {
                            chooseLang = languageList[index].mainText;
                            chooseButton = true;
                            langCode = languageList[index].langCode;
                          });
                        },
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class languageCardWidget extends StatelessWidget {
  languageCardWidget({
    required this.model,
    required this.function,
    required this.value,
    Key? key,
  }) : super(key: key);

  final ChooseLangModel model;
  final VoidCallback function;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
            border: value ? Border.all(color: Theme.of(context).primaryColor, width: 1) : null,
            color: Color(0xffd2f3e0),
            borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  model.mainText,
                  style: TextStyle(color: Colors.black, fontFamily: "Montserrat-Bold", fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              value
                  ? Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  model.langHint,
                  style: TextStyle(color: Colors.black, fontFamily: "Montserrat-Regular", fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseLangModel {
  ChooseLangModel({
    required this.langHint,
    required this.mainText,
    required this.langCode,
  });

  final String mainText;
  final String langHint;
  final String langCode;
}
