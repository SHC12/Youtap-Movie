import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/movie/controllers/movie_controller.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/large_poster_card.dart';
import 'package:youtap_movie/app/modules/shared/widget/medium_poster_card.dart';

import '../controllers/home_controller.dart';
import 'widget/refresh_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  MovieController movieController = Get.put(MovieController());
  TextEditingController tSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    movieController.fetchNowPlaying();
    movieController.fetchPopular();
  }

  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackPrimary,
        body: SafeArea(
            child: RefreshWidget(
          onRefresh: refresh,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: Get.width / 1.5,
                              child: Text(
                                'Hello,' + ' Dedi Kurniawan',
                                style:
                                    whiteTextFont.copyWith(fontSize: Get.height * 0.025, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child:
                              SvgPicture.asset('assets/svg/avatar.svg', width: Get.height * 0.07, color: yellowPrimary),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
                      child: GestureDetector(
                        onTap: () {
                          // Get.to(SearchMoviePage());
                        },
                        child: TextField(
                          onSubmitted: (value) {
                            // Get.to(SearchMoviePage());
                          },
                          style: whiteTextFont,
                          controller: tSearch,
                          enabled: false,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search, color: Colors.white),
                              labelStyle: whiteTextFont,
                              hintText: "Cari....",
                              hintStyle: whiteTextFont,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.w, bottom: 0.h),
                          child: Text('Now Playing',
                              style: whiteTextFont.copyWith(fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
                        ),
                        Obx(() {
                          return !movieController.isLoading.value
                              ? Container(
                                  height: Get.height * 0.4,
                                  child: ListView.builder(
                                      itemCount: movieController.listNowPlaying.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          width: Get.width * 0.5,
                                          margin: EdgeInsets.only(
                                              left: (index == 0) ? 24 : 0,
                                              right: (index == movieController.listNowPlaying.length - 1) ? 20 : 16),
                                          child: LargePosterCard(
                                            movieController.listNowPlaying[index].posterPath!,
                                            onTap: () {
                                              // movieController.fetchDetailMovie(
                                              //     movieController.listNowPlaying[index].id.toString(),
                                              //     isNowPlaying: true);
                                              // print(movieController.listNowPlaying[index].id);
                                            },
                                          ),
                                        );
                                      }),
                                )
                              : Shimmer.fromColors(
                                  child: CarouselSlider.builder(
                                    itemCount: 3,
                                    itemBuilder: (context, index, relIdx) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: (index == 0) ? 0 : 0, right: (index == 3 - 1) ? 20 : 16),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white10,
                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                          height: Get.height * 0.3,
                                          width: Get.width * 0.2,
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: Get.height * 0.4,
                                      enableInfiniteScroll: false,
                                      viewportFraction: 0.60,
                                      disableCenter: true,
                                      enlargeCenterPage: true,
                                      initialPage: 0,
                                      onPageChanged: (index, reason) {
                                        // setState(() {
                                        //   _currentSliderNowPlaying = index;
                                        // });
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                  baseColor: Colors.white60,
                                  highlightColor: Colors.grey[300]!,
                                );
                        })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 24),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.w, bottom: 0.h),
                          child: Text('Popular',
                              style: whiteTextFont.copyWith(fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
                        ),
                        Obx(() {
                          return !movieController.isLoading.value
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  height: 26.h,
                                  child: ListView.builder(
                                      itemCount: movieController.listPopular.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          width: 50.w,
                                          margin: EdgeInsets.only(
                                              left: (index == 0) ? 24 : 0,
                                              right: (index == movieController.listPopular.length - 1) ? 20 : 16),
                                          child: MediumPosterCard(
                                            movie: movieController.listPopular[index],
                                            onTap: () {},
                                          ),
                                        );
                                      }),
                                )
                              : Shimmer.fromColors(
                                  child: CarouselSlider.builder(
                                    itemCount: 3,
                                    itemBuilder: (context, index, relIdx) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: (index == 0) ? 0 : 0, right: (index == 3 - 1) ? 20 : 16),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white10,
                                              borderRadius: BorderRadius.all(Radius.circular(8))),
                                          height: Get.height * 0.3,
                                          width: Get.width * 0.2,
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: Get.height * 0.4,
                                      enableInfiniteScroll: false,
                                      viewportFraction: 0.60,
                                      disableCenter: true,
                                      enlargeCenterPage: true,
                                      initialPage: 0,
                                      onPageChanged: (index, reason) {},
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                  baseColor: Colors.white60,
                                  highlightColor: Colors.grey[300]!,
                                );
                        })
                      ],
                    ),
                  ),
                  // Obx(() {
                  //   return Visibility(
                  //     visible: !nobarController.isLoading.value && nobarController.listNobar.length == 0 ? false : true,
                  //     child: Container(
                  //       // padding: EdgeInsets.only(left: 24),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 24, bottom: 24),
                  //             child: Text('Nobar',
                  //                 style: whiteTextFont.copyWith(
                  //                     fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
                  //           ),
                  //           !nobarController.isLoading.value
                  //               ? CarouselSlider.builder(
                  //                   itemCount: nobarController.listNobar.length > 10
                  //                       ? nobarController.listNobar.sublist(0, 10)
                  //                       : nobarController.listNobar.length,
                  //                   itemBuilder: (context, index, realIdx) {
                  //                     return Container(
                  //                         margin: EdgeInsets.only(
                  //                             left: (index == 0) ? 0 : 0, right: (index == 3 - 1) ? defaultMargin : 16),
                  //                         child: NobarCard(
                  //                           nobarController.listNobar[index],
                  //                           onTap: () {
                  //                             nobarController
                  //                                 .fetchParticipant(nobarController.listNobar[index].idNobar);

                  //                             Get.to(DetailNobarPage(nobarController.listNobar[index]));
                  //                           },
                  //                         ));
                  //                   },
                  //                   options: CarouselOptions(
                  //                     height: Get.height * 0.24,
                  //                     enableInfiniteScroll: false,
                  //                     viewportFraction: 0.90,
                  //                     disableCenter: true,
                  //                     initialPage: 0,
                  //                     onPageChanged: (index, reason) {
                  //                       setState(() {
                  //                         _currentSliderNowPlaying = index;
                  //                       });
                  //                     },
                  //                     scrollDirection: Axis.horizontal,
                  //                   ),
                  //                 )
                  //               : Shimmer.fromColors(
                  //                   child: CarouselSlider.builder(
                  //                     itemCount: 3,
                  //                     itemBuilder: (context, index, relIdx) {
                  //                       return Container(
                  //                         margin: EdgeInsets.only(
                  //                             left: (index == 0) ? 0 : 0, right: (index == 3 - 1) ? defaultMargin : 16),
                  //                         child: Container(
                  //                           decoration: BoxDecoration(
                  //                               color: Colors.white10,
                  //                               borderRadius: BorderRadius.all(Radius.circular(8))),
                  //                           width: Get.width * 0.6,
                  //                         ),
                  //                       );
                  //                     },
                  //                     options: CarouselOptions(
                  //                       height: MediaQuery.of(context).size.height * 0.24,
                  //                       enableInfiniteScroll: false,
                  //                       viewportFraction: 0.90,
                  //                       initialPage: 0,
                  //                       disableCenter: true,
                  //                       onPageChanged: (index, reason) {
                  //                         setState(() {
                  //                           _currentSliderNowPlaying = index;
                  //                         });
                  //                       },
                  //                       scrollDirection: Axis.horizontal,
                  //                     ),
                  //                   ),
                  //                   baseColor: Colors.white60,
                  //                   highlightColor: Colors.grey[300],
                  //                 )
                  //         ],
                  //       ),
                  //     ),
                  //   );
                  // }),
                  // SizedBox(
                  //   height: 24,
                  // ),
                  // Obx(
                  //   () => Visibility(
                  //     visible: !movieController.isLoading.value && movieController.listRamaiReview.length == 0
                  //         ? false
                  //         : true,
                  //     child: Container(
                  //       // padding: EdgeInsets.only(left: 24),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.only(left: 24, bottom: 24),
                  //             child: Text('Ramai di review',
                  //                 style: whiteTextFont.copyWith(
                  //                     fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
                  //           ),
                  //           Container(
                  //             child: Column(
                  //               children: movieController.listRamaiReview.length <= 10
                  //                   ? movieController.listRamaiReview.map((element) {
                  //                       return Padding(
                  //                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  //                         child: WidthMovieCard(
                  //                           element,
                  //                           onTap: () {
                  //                             print(element.id.toString());
                  //                             movieController.fetchDetailMovie(element.id.toString());
                  //                           },
                  //                         ),
                  //                       );
                  //                     }).toList()
                  //                   : movieController.listRamaiReview.sublist(0, 10).map((element) {
                  //                       return Padding(
                  //                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  //                         child: WidthMovieCard(
                  //                           element,
                  //                           onTap: () {
                  //                             print(element.id.toString());
                  //                             movieController.fetchDetailMovie(element.id.toString());
                  //                           },
                  //                         ),
                  //                       );
                  //                     }).toList(),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 24,
                  // ),
                ],
              ),
            ],
          ),
        )));
  }
}
