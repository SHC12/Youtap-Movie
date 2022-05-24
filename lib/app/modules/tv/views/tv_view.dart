import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/home/views/widget/refresh_widget.dart';
import 'package:youtap_movie/app/modules/movie/views/widget/header_widget.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_large_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_medium_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/large_poster_card.dart';
import 'package:youtap_movie/app/modules/shared/widget/medium_poster_card.dart';
import 'package:youtap_movie/app/modules/tv/controllers/tv_controller.dart';

class TvView extends StatefulWidget {
  const TvView({Key? key}) : super(key: key);

  @override
  State<TvView> createState() => _TvViewState();
}

class _TvViewState extends State<TvView> {
  TvController tvController = Get.put(TvController());
  TextEditingController tSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    tvController.fetchOnAir();
    tvController.fetchPopular();
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
                  HeaderWidget(),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: SizedBox(
                      child: Text(
                        'Hello,' + ' Dedi Kurniawan',
                        style: whiteTextFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
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
                          child: Text('On Air', style: whiteTextFont.copyWith(fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
                        ),
                        Obx(() {
                          return !tvController.isLoading.value
                              ? Container(
                                  height: Get.height * 0.4,
                                  child: ListView.builder(
                                      itemCount: tvController.listTvOnAIr.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          width: Get.width * 0.5,
                                          margin: EdgeInsets.only(left: (index == 0) ? 24 : 0, right: (index == tvController.listTvOnAIr.length - 1) ? 20 : 16),
                                          child: LargePosterCard(
                                            tvController.listTvOnAIr[index].posterPath!,
                                            onTap: () {
                                              tvController.fetchDetailTv(tvController.listTvOnAIr[index].id.toString(), isNowPlaying: true);
                                              print(tvController.listTvOnAIr[index].id);
                                            },
                                          ),
                                        );
                                      }),
                                )
                              : ShimmerCarouselLargePoster();
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
                          child: Text('Popular', style: whiteTextFont.copyWith(fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Obx(() {
                          return !tvController.isLoading.value
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  height: 24.h,
                                  child: ListView.builder(
                                      itemCount: tvController.listTvPopular.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          width: 50.w,
                                          margin: EdgeInsets.only(left: (index == 0) ? 24 : 0, right: (index == tvController.listTvPopular.length - 1) ? 20 : 16),
                                          child: MediumPosterCard(
                                            title: tvController.listTvPopular[index].name,
                                            poster: tvController.listTvPopular[index].backdropPath,
                                            vote: tvController.listTvPopular[index].voteAverage.toString(),
                                            onTap: () {
                                              tvController.fetchDetailTv(tvController.listTvOnAIr[index].id.toString(), isNowPlaying: true);
                                              print(tvController.listTvOnAIr[index].id);
                                            },
                                          ),
                                        );
                                      }),
                                )
                              : ShimmerCarouselMediumPoster();
                        })
                      ],
                    ),
                  ),
                  // Container(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.only(left: 6.w, bottom: 0.h),
                  //         child: Text('Upcoming',
                  //             style: whiteTextFont.copyWith(fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
                  //       ),
                  //       Obx(() {
                  //         return !tvController.isLoading.value
                  //             ? Container(
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(18),
                  //                 ),
                  //                 height: 26.h,
                  //                 child: ListView.builder(
                  //                     itemCount: tvController.listUpcoming.length,
                  //                     scrollDirection: Axis.horizontal,
                  //                     itemBuilder: (ctx, index) {
                  //                       return Container(
                  //                         decoration: BoxDecoration(
                  //                           borderRadius: BorderRadius.circular(18),
                  //                         ),
                  //                         width: 50.w,
                  //                         margin: EdgeInsets.only(
                  //                             left: (index == 0) ? 24 : 0,
                  //                             right: (index == tvController.listUpcoming.length - 1) ? 20 : 16),
                  //                         child: MediumPosterCard(
                  //                           movie: tvController.listUpcoming[index],
                  //                           onTap: () {
                  //                             tvController.fetchDetailMovie(
                  //                                 tvController.listUpcoming[index].id.toString(),
                  //                                 isNowPlaying: true);
                  //                             print(tvController.listUpcoming[index].id);
                  //                           },
                  //                         ),
                  //                       );
                  //                     }),
                  //               )
                  //             : Shimmer.fromColors(
                  //                 child: CarouselSlider.builder(
                  //                   itemCount: 3,
                  //                   itemBuilder: (context, index, relIdx) {
                  //                     return Container(
                  //                       margin: EdgeInsets.only(
                  //                           left: (index == 0) ? 0 : 0, right: (index == 3 - 1) ? 20 : 16),
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                             color: Colors.white10,
                  //                             borderRadius: BorderRadius.all(Radius.circular(8))),
                  //                         height: Get.height * 0.3,
                  //                         width: Get.width * 0.2,
                  //                       ),
                  //                     );
                  //                   },
                  //                   options: CarouselOptions(
                  //                     height: Get.height * 0.4,
                  //                     enableInfiniteScroll: false,
                  //                     viewportFraction: 0.60,
                  //                     disableCenter: true,
                  //                     enlargeCenterPage: true,
                  //                     initialPage: 0,
                  //                     onPageChanged: (index, reason) {},
                  //                     scrollDirection: Axis.horizontal,
                  //                   ),
                  //                 ),
                  //                 baseColor: Colors.white60,
                  //                 highlightColor: Colors.grey[300]!,
                  //               );
                  //       })
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        )));
  }
}
