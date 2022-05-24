import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/movie/controllers/movie_controller.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/medium_poster_card.dart';

class PopularMovieView extends StatelessWidget {
  const PopularMovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieController movieController = Get.put(MovieController());
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Text('Popular', style: whiteTextFont.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: 1.h,
          ),
          Obx(() {
            return !movieController.isLoading.value
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    height: 23.h,
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
                          margin: EdgeInsets.only(left: (index == 0) ? 0 : 0, right: (index == 3 - 1) ? 20 : 16),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white10, borderRadius: BorderRadius.all(Radius.circular(8))),
                            height: 10.h,
                            width: 20.w,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 30.h,
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
    );
  }
}
