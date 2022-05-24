import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/movie/controllers/movie_controller.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_medium_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/medium_poster_card.dart';

class UpcomingMovieView extends StatelessWidget {
  const UpcomingMovieView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieController movieController = Get.put(MovieController());
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
            child: Text('Upcoming', style: whiteTextFont.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w500)),
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
                    height: 20.h,
                    child: ListView.builder(
                        itemCount: movieController.listUpcoming.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            width: 50.w,
                            margin: EdgeInsets.only(left: (index == 0) ? 24 : 0, right: (index == movieController.listUpcoming.length - 1) ? 20 : 16),
                            child: MediumPosterCard(
                              poster: movieController.listUpcoming[index].backdropPath,
                              vote: movieController.listUpcoming[index].voteAverage.toString(),
                              title: movieController.listUpcoming[index].title,
                              onTap: () {
                                movieController.fetchDetailMovie(movieController.listUpcoming[index].id.toString(), isNowPlaying: true);
                                print(movieController.listUpcoming[index].id);
                              },
                            ),
                          );
                        }),
                  )
                : ShimmerCarouselMediumPoster();
          })
        ],
      ),
    );
  }
}
