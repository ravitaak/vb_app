import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vb_app/bloc/global/global_cubit.dart';
import 'package:vb_app/generated/l10n.dart';

class WhatDescribesYou extends StatefulWidget {
  final PageController pageController;
  const WhatDescribesYou({Key? key, required this.pageController}) : super(key: key);

  @override
  _WhatDescribesYouState createState() => _WhatDescribesYouState();
}

class _WhatDescribesYouState extends State<WhatDescribesYou> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        return Column(
          children: [
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              runAlignment: WrapAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.read<GlobalCubit>().updateRegistrationBody(state.registrationBody!.copyWith(accountType: 1));
                    Future.delayed(Duration(milliseconds: 500),
                        () => {widget.pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeOut)});
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                        color: state.registrationBody?.accountType == 1 ? Theme.of(context).cardColor : Theme.of(context).cardColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(18.sp),
                        border: state.registrationBody?.accountType == 1 ? Border.all(color: Theme.of(context).primaryColor, width: 3) : null),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/student.svg',
                          width: 0.4.sw,
                        ),
                        Text(
                          AppLocalizations.of(context).Student,
                          style: TextStyle(
                            fontFamily: "Montserrat-Bold",
                            color: state.registrationBody?.accountType == 1 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<GlobalCubit>().updateRegistrationBody(state.registrationBody!.copyWith(accountType: 2));
                    Future.delayed(Duration(milliseconds: 500),
                        () => {widget.pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeOut)});
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                        color: state.registrationBody?.accountType == 2 ? Theme.of(context).cardColor : Theme.of(context).cardColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(18.sp),
                        border: state.registrationBody?.accountType == 2 ? Border.all(color: Theme.of(context).primaryColor, width: 3) : null),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/teacher.svg',
                          width: 0.4.sw,
                        ),
                        Text(
                          AppLocalizations.of(context).Teacher,
                          style: TextStyle(
                            fontFamily: "Montserrat-Bold",
                            color: state.registrationBody?.accountType == 2 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<GlobalCubit>().updateRegistrationBody(state.registrationBody!.copyWith(accountType: 3));
                    Future.delayed(Duration(milliseconds: 500),
                        () => {widget.pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeOut)});
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                        color: state.registrationBody?.accountType == 3 ? Theme.of(context).cardColor : Theme.of(context).cardColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(18.sp),
                        border: state.registrationBody?.accountType == 3 ? Border.all(color: Theme.of(context).primaryColor, width: 3) : null),
                    child: Column(
                      children: [
                        // SvgPicture.asset(
                        //   'assets/images/parent.svg',
                        //   width: 0.4.sw,
                        // ),
                        Text(
                          AppLocalizations.of(context).Parent,
                          style: TextStyle(
                            fontFamily: "Montserrat-Bold",
                            color: state.registrationBody?.accountType == 3 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<GlobalCubit>().updateRegistrationBody(state.registrationBody!.copyWith(accountType: 4));
                    Future.delayed(Duration(milliseconds: 500),
                        () => {widget.pageController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.easeOut)});
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                        color: state.registrationBody?.accountType == 4 ? Theme.of(context).cardColor : Theme.of(context).cardColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(18.sp),
                        border: state.registrationBody?.accountType == 4 ? Border.all(color: Theme.of(context).primaryColor, width: 3) : null),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/aspirant.svg',
                          width: 0.4.sw,
                        ),
                        Text(
                          AppLocalizations.of(context).Aspirant,
                          style: TextStyle(
                            fontFamily: "Montserrat-Bold",
                            color: state.registrationBody?.accountType == 4 ? Theme.of(context).primaryColor : Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.sp,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: TextButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.chevron_left_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          AppLocalizations.of(context).GoBack,
                          style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: "Montserrat-Bold"),
                        ),
                      ],
                    ),
                    onPressed: () {
                      widget.pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
