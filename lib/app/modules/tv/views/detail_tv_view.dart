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
import 'package:youtap_movie/app/modules/tv/controllers/tv_controller.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class DetailTvView extends StatefulWidget {
  final bool? isNowPlaying;
  const DetailTvView({Key? key, this.isNowPlaying}) : super(key: key);

  @override
  State<DetailTvView> createState() => _DetailTvViewState();
}

class _DetailTvViewState extends State<DetailTvView> {
  TvController tvController = Get.put(TvController());
  ReviewController reviewController = Get.put(ReviewController());
  TextEditingController tReview = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
          tvController.detailTv.value.name ?? '',
          style: whiteTextFont.copyWith(fontWeight: FontWeight.bold, fontSize: Get.height * 0.025),
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
                      Container(
                        color: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.warning_amber_rounded, color: Colors.white),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text('Jika menemukan review yang merupakan spoiler, silahkan dilaporkan dengan menekan tombol lapor', style: whiteTextFont.copyWith(fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned.fill(
                            bottom: 10,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: Get.width * 0.58,
                                height: Get.height * 0.04,
                                decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            bottom: 18,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: Get.width * 0.58,
                                height: Get.height * 0.04,
                                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24))),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(24),
                            child: Center(
                              child: tvController.detailTv.value.posterPath == ""
                                  ? Container(
                                      width: Get.width * 0.6,
                                      height: Get.height * 0.5,
                                      child: Center(
                                        child: Text('NO POSTER', style: whiteTextFont),
                                      ),
                                    )
                                  : Hero(
                                      tag: 'large-poster-' + tvController.detailTv.value.posterPath!,
                                      child: Container(
                                        width: Get.width * 0.6,
                                        height: Get.height * 0.5,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), image: DecorationImage(image: NetworkImage(UrlListService.baseUrlImageW500 + tvController.detailTv.value.posterPath!), fit: BoxFit.fill)),
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
                              tvController.detailTv.value.name ?? "",
                              style: whiteTextFont.copyWith(fontSize: Get.height * 0.03, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Tanggal Rilis : ' + tvController.detailTv.value.firstAirDate!,
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '|',
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  tvController.detailTv.value.voteAverage.toString(),
                                  style: whiteTextFont,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.star,
                                  color: yellowPrimary,
                                  size: Get.height * 0.02,
                                )
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Visibility(
                              visible: true,
                              child: Wrap(
                                children: tvController.detailTv.value.genres!
                                    .map((e) => Padding(
                                          padding: EdgeInsets.only(right: 8.0, top: 8),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(color: RandomColor().randomColor(colorBrightness: ColorBrightness.dark), borderRadius: BorderRadius.circular(8)),
                                            child: Text(
                                              e.name!,
                                              style: whiteTextFont.copyWith(fontSize: Get.height * 0.015),
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Text(
                              'Aktor & Kru',
                              style: whiteTextFont.copyWith(fontSize: Get.height * 0.02, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Visibility(
                              visible: true,
                              child: Container(
                                  width: Get.width,
                                  height: Get.height * 0.15,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tvController.listCredits.value.cast!.length,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 8),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: Get.width * 0.2,
                                                    height: Get.height * 0.1,
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
                                                    child: tvController.listCredits.value.cast![i].profilePath != null
                                                        ? Image.network(
                                                            UrlListService.baseUrlImageW500 + tvController.listCredits.value.cast![i].profilePath!,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : SvgPicture.asset('assets/svg/avatar.svg', color: RandomColor().randomColor(colorBrightness: ColorBrightness.light)),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    tvController.listCredits.value.cast![i].name!,
                                                    style: whiteTextFont,
                                                  ),
                                                  Text(
                                                    tvController.listCredits.value.cast![i].character!,
                                                    style: yellowTextFont.copyWith(fontSize: 8),
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
                              'Sinopsis',
                              style: whiteTextFont.copyWith(fontSize: Get.height * 0.02, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Text(
                              tvController.detailTv.value.overview ?? "",
                              style: whiteTextFont.copyWith(fontSize: Get.height * 0.015),
                              overflow: TextOverflow.clip,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Review',
                                  style: whiteTextFont.copyWith(fontSize: Get.height * 0.02, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Obx(() => reviewController.listReviewMovie.length == 0 && !reviewController.isLoading.value
                                ? Center(child: Text('Belum ada review', style: whiteTextFont))
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
                            SizedBox(
                              height: 30,
                            )
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
