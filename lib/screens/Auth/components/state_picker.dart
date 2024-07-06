import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vb_app/bloc/global/global_cubit.dart';
import 'package:vb_app/data/services/models/district.dart';
import 'package:vb_app/data/services/models/registration_body.dart' as Auth;
import 'package:vb_app/data/services/models/states.dart';
import 'package:vb_app/generated/l10n.dart';

class StatePicker extends StatefulWidget {
  @override
  _StatePickerState createState() => _StatePickerState();
}

class _StatePickerState extends State<StatePicker> {
  String searchText = "";
  int pageIndex = 0;
  PageController pageController = PageController();
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "${AppLocalizations.of(context).Choose} ${pageIndex == 0 ? "${AppLocalizations.of(context).State}" : "${AppLocalizations.of(context).District}"}",
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<GlobalCubit, GlobalState>(
                builder: (context, state) {
                  if (state.states?.isEmpty ?? true) {
                    context.read<GlobalCubit>().getStates();
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                      ),
                    );
                  } else {
                    List<States> sortedStates = searchText.isEmpty
                        ? state.states!
                        : state.states!.where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase())).toList();
                    sortedStates.sort((a, b) {
                      return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
                    });
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: TextField(
                                      cursorColor: Color(0xff2ed573),
                                      controller: searchTextController,
                                      style: TextStyle(color: Theme.of(context).hintColor),
                                      onChanged: (change) {
                                        setState(() {
                                          searchText = change;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        counterText: "",
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: Color(0xff2ed573),
                                        ),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Montserrat-Light",
                                          color: Colors.black54,
                                        ),
                                        hintText:
                                            "${AppLocalizations.of(context).Search} ${pageIndex == 0 ? "${AppLocalizations.of(context).State}" : "${AppLocalizations.of(context).District}"}",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child: PageView(
                          onPageChanged: (index) => setState(() {
                            pageIndex = index;
                          }),
                          controller: pageController,
                          physics: BouncingScrollPhysics(),
                          children: [
                            ListView.builder(
                                itemCount: sortedStates.length,
                                itemBuilder: (ctx, index) {
                                  return ListTile(
                                    onTap: () {
                                      context.read<GlobalCubit>().updateRegistrationBody(
                                          state.registrationBody!.copyWith(state: Auth.State.fromJson(sortedStates[index].toJson())));
                                      context.read<GlobalCubit>().getDistrict(sortedStates[index].id);
                                      context.read<GlobalCubit>().resetDistrict();
                                      setState(() {
                                        searchText = "";
                                        searchTextController.text = "";
                                      });
                                      pageController.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                                    },
                                    contentPadding: EdgeInsets.symmetric(horizontal: 26.sp),
                                    title: Text(sortedStates[index].name!),
                                    trailing: Icon(
                                      Icons.chevron_right,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  );
                                }),
                            state.district == null
                                ? SizedBox()
                                : Builder(
                                    builder: (context) {
                                      List<District>? districts;
                                      if (pageIndex == 1) {
                                        districts = searchText.isEmpty
                                            ? state.district
                                            : state.district!
                                                .where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase()))
                                                .toList();
                                      }
                                      return districts != null
                                          ? ListView.builder(
                                              itemCount: districts.length,
                                              itemBuilder: (ctx, index) {
                                                return ListTile(
                                                  onTap: () {
                                                    context.read<GlobalCubit>().updateRegistrationBody(state.registrationBody!
                                                        .copyWith(district: Auth.District.fromJson(districts![index].toJson())));
                                                    Navigator.pop(context);
                                                  },
                                                  contentPadding: EdgeInsets.symmetric(horizontal: 26.sp),
                                                  title: Text(districts![index].name!),
                                                );
                                              })
                                          : SizedBox();
                                    },
                                  )
                          ],
                        )),
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
