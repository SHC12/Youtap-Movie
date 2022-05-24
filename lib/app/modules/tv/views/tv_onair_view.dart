import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_large_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/large_poster_card.dart';
import 'package:youtap_movie/app/modules/tv/controllers/tv_controller.dart';

class TVOnAirView extends StatelessWidget {
  const TVOnAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TvController tvController = Get.put(TvController());
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 6.w, bottom: 0.h),
            child: Text('On Air', style: whiteTextFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500)),
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
                            margin: EdgeInsets.only(
                                left: (index == 0) ? 24 : 0,
                                right: (index == tvController.listTvOnAIr.length - 1) ? 20 : 16),
                            child: LargePosterCard(
                              tvController.listTvOnAIr[index].posterPath!,
                              onTap: () {
                                tvController.fetchDetailTv(tvController.listTvOnAIr[index].id.toString(),
                                    isNowPlaying: true);
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
    );
  }
}
