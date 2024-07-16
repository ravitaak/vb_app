import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vb_app/bloc/vb/vidya_box_cubit.dart';

import '../../data/services/models/vidyabox_slides.dart';
import 'Premium/v4/index.dart';

class HomeWrapper extends StatefulWidget {
  HomeWrapper();
  @override
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  final _pageControllerL = PageController(viewportFraction: 0.877);
  final _pageControllerU = PageController(viewportFraction: 0.877);

  double currentPageL = 0;
  double currentPageU = 0;

  final ScrollController _scrollController = ScrollController();

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<VidyaBoxCubit>().fetchVidyaBoxSlides();
    _pageControllerL.addListener(() {
      setState(() {
        currentPageL = _pageControllerL.page!.toDouble();
        print(currentPageL);
      });
    });
    _pageControllerU.addListener(() {
      setState(() {
        currentPageU = _pageControllerU.page!.toDouble();
        print(currentPageU);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 20.sp,
              ),
              BlocBuilder<VidyaBoxCubit, VbState>(
                builder: (context, state) {
                  switch (state.slidesLoading) {
                    case SlidesLoading.loading:
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    case SlidesLoading.fetched:
                      List<VidyaBoxSlide>? vidyaboxSlides = state.vidyaboxSlides;
                      List<VidyaBoxSlide> upperSlides = vidyaboxSlides!.where((slide) => slide.name == 'UPPER').toList();
                      upperSlides.sort((a, b) => a.priority!.compareTo(b.priority!));
                      return Container(
                        height: 200,
                        child: PageView(
                            //boucingscrollphysics() membuat efek mantul saat discroll ke samping

                            physics: BouncingScrollPhysics(),
                            controller: _pageControllerU,

                            //make pageview scrollable sideways
                            scrollDirection: Axis.horizontal,
                            children: upperSlides
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 350,
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl: e.thumbnail!,
                                      imageBuilder: (context, imageProvider) => Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                )
                                .toList()),
                      );

                    case SlidesLoading.initial:
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    case SlidesLoading.error:
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 14.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Text("Something went wrong\nPlease Try again later.")
                          ],
                        ),
                      );
                  }
                },
              ),
              SizedBox(
                height: 8.sp,
              ),
              BlocBuilder<VidyaBoxCubit, VbState>(
                builder: (context, state) {
                  switch (state.slidesLoading) {
                    case SlidesLoading.loading:
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    case SlidesLoading.fetched:
                      List<VidyaBoxSlide>? vidyaboxSlides = state.vidyaboxSlides;
                      List<VidyaBoxSlide> lowerSlides = vidyaboxSlides!.where((slide) => slide.name == 'LOWER').toList();
                      lowerSlides.sort((a, b) => a.priority!.compareTo(b.priority!));
                      return Container(
                        height: 200,
                        child: PageView(
                            //boucingscrollphysics() membuat efek mantul saat discroll ke samping

                            physics: BouncingScrollPhysics(),
                            controller: _pageControllerL,

                            //make pageview scrollable sideways
                            scrollDirection: Axis.horizontal,
                            children: lowerSlides
                                .map(
                                  (e) => Container(
                                    margin: EdgeInsets.only(right: 15),
                                    width: 350,
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl: e.thumbnail!,
                                      imageBuilder: (context, imageProvider) => Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  ),
                                )
                                .toList()),
                      );

                    case SlidesLoading.initial:
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    case SlidesLoading.error:
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.sp, horizontal: 14.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Text("Something went wrong\nPlease Try again later.")
                          ],
                        ),
                      );
                  }
                },
              ),

              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              //   child: Row(
              //     children: [
              //       SizedBox(
              //         width: .38.sw,
              //         child: Image.asset('assets/images/Vidyabox.png'),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             "Vidyabox: Physical Device",
              //             style: TextStyle(fontFamily: 'Montserrat-Bold'),
              //           ),
              //           Text(
              //             "#PhoneFreeLearning",
              //             style: TextStyle(
              //               fontFamily: 'Montserrat',
              //               color: Theme.of(context).primaryColor,
              //             ),
              //           ),
              //           SizedBox(
              //             height: 4,
              //           ),
              //           Material(
              //             color: Theme.of(context).hoverColor,
              //             borderRadius: BorderRadius.circular(12),
              //             child: InkWell(
              //               borderRadius: BorderRadius.circular(12),
              //               onTap: () {
              //                 launch("https://vidyabox.in");
              //               },
              //               child: Container(
              //                 padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
              //                 child: Text(
              //                   "Learn more",
              //                   style: TextStyle(
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.white,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              Divider(),
              Padding(padding: EdgeInsets.all(12), child: VidyaBoxContainer()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.sp),
        color: Theme.of(context).primaryColor,
        height: .1.sh,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: _scrollToEnd,
              child: Container(
                height: .05.sh,
                width: .35.sw,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12.sp),
                    // border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(color: Colors.black54, offset: Offset(0, 0), blurRadius: 2),
                    ]),
                child: Center(
                    child: Text(
                  "Order Now 🛒",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ),
            ),
            InkWell(
              onTap: () async {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen(),));
                String url = await context.read<VidyaBoxCubit>().getUrl();
                log(url);
                launch(url);
              },
              child: Container(
                height: .05.sh,
                width: .35.sw,
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12.sp), boxShadow: [
                  BoxShadow(color: Colors.black54, offset: Offset(0, 0), blurRadius: 2),
                ]),
                child: Center(
                    child: Text(
                  "Free Demo 🆓",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
