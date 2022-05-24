import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:random_color/random_color.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/movie/controllers/movie_controller.dart';
import 'package:youtap_movie/app/modules/movie/controllers/review_controller.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/review_card.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class DetailMovieView extends StatefulWidget {
  final bool? isNowPlaying;
  const DetailMovieView({Key? key, this.isNowPlaying}) : super(key: key);

  @override
  State<DetailMovieView> createState() => _DetailMovieViewState();
}

class _DetailMovieViewState extends State<DetailMovieView> {
  MovieController movieController = Get.put(MovieController());
  ReviewController reviewController = Get.put(ReviewController());
  TextEditingController tReview = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          movieController.detailMovie.value.title ?? '',
          style: whiteTextFont.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back(closeOverlays: true);
            },
            child: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      backgroundColor: blackPrimary,
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Positioned.fill(
                            bottom: 10,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 52.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            bottom: 18,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 60.w,
                                height: 42.h,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: movieController.detailMovie.value.posterPath == ""
                                  ? Container(
                                      width: 60.w,
                                      height: 50.h,
                                      child: Center(
                                        child: Text('NO POSTER', style: whiteTextFont),
                                      ),
                                    )
                                  : Hero(
                                      tag: 'large-poster-' + movieController.detailMovie.value.posterPath!,
                                      child: Container(
                                        width: 60.w,
                                        height: 50.h,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            image: DecorationImage(
                                                image: NetworkImage(UrlListService.baseUrlImageW500 +
                                                    movieController.detailMovie.value.posterPath!),
                                                fit: BoxFit.fill)),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieController.detailMovie.value.title ?? "",
                              style: whiteTextFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Release Date : ' + movieController.detailMovie.value.releaseDate!,
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '|',
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  movieController.detailMovie.value.voteAverage.toString(),
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Icon(
                                  Icons.star,
                                  color: yellowPrimary,
                                  size: 14.sp,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Visibility(
                              visible: true,
                              child: Wrap(
                                children: movieController.detailMovie.value.genres!
                                    .map((e) => Padding(
                                          padding: EdgeInsets.only(right: 8.0, top: 8),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                                color: RandomColor().randomColor(colorBrightness: ColorBrightness.dark),
                                                borderRadius: BorderRadius.circular(8)),
                                            child: Text(
                                              e.name!,
                                              style: whiteTextFont.copyWith(fontSize: 10.sp),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              'Cast',
                              style: whiteTextFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Visibility(
                              visible: true,
                              child: Container(
                                  height: 18.h,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: movieController.listCredits.value.cast!.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 20.w,
                                                    height: 10.h,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(20))),
                                                    child: movieController.listCredits.value.cast![i].profilePath !=
                                                            null
                                                        ? Image.network(
                                                            UrlListService.baseUrlImageW500 +
                                                                movieController.listCredits.value.cast![i].profilePath!,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : SvgPicture.asset('assets/svg/avatar.svg',
                                                            color: RandomColor()
                                                                .randomColor(colorBrightness: ColorBrightness.light)),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Text(
                                                    movieController.listCredits.value.cast![i].name!,
                                                    style: whiteTextFont,
                                                  ),
                                                  Text(
                                                    movieController.listCredits.value.cast![i].character!,
                                                    style: yellowTextFont.copyWith(fontSize: 10.sp),
                                                  )
                                                ],
                                              ),
                                            ));
                                      })),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Text(
                              'Synopsis',
                              style: whiteTextFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              movieController.detailMovie.value.overview ?? "",
                              style: whiteTextFont.copyWith(fontSize: 10.sp),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Review',
                                  style: whiteTextFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Obx(() => reviewController.listReviewMovie.length == 0 && !reviewController.isLoading.value
                                ? Center(child: Text('No reviews yet', style: whiteTextFont))
                                : reviewController.listReviewMovie.length > 0 && !reviewController.isLoading.value
                                    ? Container(
                                        width: Get.width,
                                        child: Column(
                                          children: reviewController.listReviewMovie
                                              .map((element) => Padding(
                                                    padding: EdgeInsets.only(top: 8.0, bottom: 6),
                                                    child: ReviewCard(element),
                                                  ))
                                              .toList(),
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                        backgroundColor: yellowPrimary,
                                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                      ))),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
