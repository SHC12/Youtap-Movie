import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/movie/controllers/movie_controller.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_large_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/large_poster_card.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieController movieController = Get.put(MovieController());
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Text('Now Playing', style: whiteTextFont.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500)),
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
                    height: 30.h,
                    child: ListView.builder(
                        itemCount: movieController.listNowPlaying.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            margin: EdgeInsets.only(left: (index == 0) ? 10 : 0, right: (index == movieController.listNowPlaying.length - 1) ? 10 : 16),
                            width: 50.w,
                            child: LargePosterCard(
                              movieController.listNowPlaying[index].posterPath!,
                              onTap: () {
                                movieController.fetchDetailMovie(movieController.listNowPlaying[index].id.toString(), isNowPlaying: true);
                              },
                            ),
                          );
                        }),
                  )
                : ShimmerCarouselLargePoster();
          })
        ],
      ),
    );
  }
}
