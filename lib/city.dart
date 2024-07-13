import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'bloc/user/user_cubit.dart';
import 'data/database/db.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  bool chooseButton = false;
  String chooseCity = "";
  Database _database = GetIt.I<Database>();
  TbUserData? userData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.sp, vertical: 8.sp),
        child: InkWell(
          onTap: () async {
            userData = await _database.userDao.getUser();
            var data = {
              'id': userData!.id,
              'city': chooseCity
            };



            var res = await context.read<UserCubit>().updateUser(data);
            log(res.toString());
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
                  width: 4.sp
                  ,
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
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Select City",
                  style: TextStyle(color: Colors.black, fontFamily: "Montserrat-Bold", fontSize: 25, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 14.sp, mainAxisSpacing: 14.sp, childAspectRatio: 1.sp),
                    itemCount: cityList.length,
                    itemBuilder: (context, index) {
                      return CityCardWidget(
                        model: cityList[index],
                        value: chooseCity == cityList[index].mainText ? true : false,
                        function: () {
                          setState(() {
                            chooseCity = cityList[index].mainText;
                            chooseButton = true;
                          });
                        },
                      );
                    }),
                SizedBox(height: 12,),
                InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            elevation: 0,
                            actions: [
                              SizedBox(height: 16.sp,),
                              TextFormField(
                                decoration: InputDecoration(

                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                  // hintText: "Enter city name "
                                  label: Text("Enter city name")
                                ),
                              ),

                              SizedBox(height: 16.sp,),
                              Row(

                                children: [
                                  Container(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey,offset: Offset(0,0),blurRadius: 2)
                                    ]
                                  ),child: Center(child: Text("Save",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(24),),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Other",style: TextStyle(color: Colors.black, fontFamily: "Montserrat-Bold", fontSize: 16, fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_forward_ios_rounded,size: 18,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CityCardWidget extends StatelessWidget {
  CityCardWidget({
    required this.function,
    required this.value,
    required this.model,
    Key? key,
  }) : super(key: key);

  final VoidCallback function;
  final ChooseCityModel model;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: .4.sw,
        height: .3.sw,
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

class ChooseCityModel {
  ChooseCityModel({
    required this.langHint,
    required this.mainText,
  });
  final String mainText;
  final String langHint;
}

List<ChooseCityModel> cityList = [
  ChooseCityModel(langHint: "मुम्बई", mainText: "Mumbai",),
  ChooseCityModel(langHint: "दिल्ली", mainText: "Delhi",),
];