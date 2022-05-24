import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_large_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_medium_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/large_poster_card.dart';
import 'package:youtap_movie/app/modules/shared/widget/medium_poster_card.dart';
import 'package:youtap_movie/app/modules/tv/controllers/tv_controller.dart';

class PopularTVView extends StatelessWidget {
  const PopularTVView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TvController tvController = Get.put(TvController());
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.w, bottom: 0.h),
            child: Text('Popular',
                style: whiteTextFont.copyWith(fontSize: Get.height * 0.024, fontWeight: FontWeight.w500)),
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
                            margin: EdgeInsets.only(
                                left: (index == 0) ? 24 : 0,
                                right: (index == tvController.listTvPopular.length - 1) ? 20 : 16),
                            child: MediumPosterCard(
                              title: tvController.listTvPopular[index].name,
                              poster: tvController.listTvPopular[index].backdropPath,
                              vote: tvController.listTvPopular[index].voteAverage.toString(),
                              onTap: () {
                                tvController.fetchDetailTv(tvController.listTvOnAIr[index].id.toString(),
                                    isNowPlaying: true);
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
    );
  }
}
