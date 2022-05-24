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
    movieController.fetchUpcoming();
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
                                              movieController.fetchDetailMovie(
                                                  movieController.listNowPlaying[index].id.toString(),
                                                  isNowPlaying: true);
                                              print(movieController.listNowPlaying[index].id);
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
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6.w, bottom: 0.h),
                          child: Text('Upcoming',
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
                                      itemCount: movieController.listUpcoming.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          width: 50.w,
                                          margin: EdgeInsets.only(
                                              left: (index == 0) ? 24 : 0,
                                              right: (index == movieController.listUpcoming.length - 1) ? 20 : 16),
                                          child: MediumPosterCard(
                                            movie: movieController.listUpcoming[index],
                                            onTap: () {
                                              movieController.fetchDetailMovie(
                                                  movieController.listUpcoming[index].id.toString(),
                                                  isNowPlaying: true);
                                              print(movieController.listUpcoming[index].id);
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
                ],
              ),
            ],
          ),
        )));
  }
}
