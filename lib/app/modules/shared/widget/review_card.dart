import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/data/review_movie_model.dart';
import 'package:youtap_movie/app/modules/movie/controllers/review_controller.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class ReviewCard extends StatefulWidget {
  final Review? review;

  ReviewCard(this.review);

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  final reviewController = Get.put(ReviewController());
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    // if (isLiked || widget.review.isLiked == "1") {
    //   reviewController.feedbackReview(widget.review.idReview, 'unlike');
    // } else {
    //   reviewController.feedbackReview(widget.review.idReview, 'like');
    // }

    return !isLiked;
  }

  Future<bool> onReportButtonTapped(bool isReport) async {
    // if (isReport || widget.review.isReport == "1") {
    //   reviewController.feedbackReview(widget.review.idReview, 'unreport');
    // } else {
    //   reviewController.feedbackReview(widget.review.idReview, 'report');
    // }

    return !isReport;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
        width: Get.width,
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.review!.authorDetails!.avatarPath == ""
                    ? SvgPicture.asset('assets/svg/avatar.svg', width: Get.height * 0.08, color: yellowPrimary)
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 10.h,
                        width: 20.w,
                        child: Image.network(
                          widget.review!.authorDetails!.avatarPath!.contains('https') ? widget.review!.authorDetails!.avatarPath!.substring(1) : UrlListService.baseUrlImage + widget.review!.authorDetails!.avatarPath!,
                        ),
                      ),
                SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review!.author!,
                      style: whiteTextFont.copyWith(fontWeight: FontWeight.w700, fontSize: Get.height * 0.015),
                    ),
                    SizedBox(
                      width: 50.w,
                      child: ReadMoreText(
                        '"' + widget.review!.content! + '"',
                        // overflow: TextOverflow.clip,
                        style: whiteTextFont.copyWith(fontSize: Get.height * 0.015),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     LikeButton(
                    //       onTap: onLikeButtonTapped,
                    //       size: Get.height * 0.05,
                    //       circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    //       bubblesColor: BubblesColor(
                    //         dotPrimaryColor: Color(0xff33b5e5),
                    //         dotSecondaryColor: Color(0xff0099cc),
                    //       ),
                    //       likeBuilder: (bool isLiked) {
                    //         // return Icon(
                    //         //   Icons.thumb_up,
                    //         //   color: isLiked || widget.review.isLiked == "1"
                    //         //       ? yellowPrimary
                    //         //       : Colors.grey,
                    //         //   size: Get.height * 0.02,
                    //         // );
                    //       },
                    //       // likeCount: int.parse(widget.review.likeCount),
                    //       // countBuilder:
                    //       //     (int count, bool isLiked, String text) {
                    //       //   var color = isLiked ? Colors.white : Colors.grey;
                    //       //   Widget result;
                    //       //   if (count == 0) {
                    //       //     result = Text(
                    //       //       "Suka",
                    //       //       style: whiteTextFont.copyWith(fontSize: 12),
                    //       //     );
                    //       //   } else
                    //       //     result = Text(
                    //       //       text,
                    //       //       style: TextStyle(color: color),
                    //       //     );
                    //       //   return result;
                    //       // },
                    //     ),
                    //     LikeButton(
                    //       onTap: onReportButtonTapped,
                    //       size: Get.height * 0.05,
                    //       circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    //       bubblesColor: BubblesColor(
                    //         dotPrimaryColor: Color(0xff33b5e5),
                    //         dotSecondaryColor: Color(0xff0099cc),
                    //       ),
                    //       likeBuilder: (bool isLiked) {
                    //         // return Icon(
                    //         //   Icons.flag,
                    //         //   color: isLiked || widget.review.isReport == "1"
                    //         //       ? Colors.red
                    //         //       : Colors.grey,
                    //         //   size: Get.height * 0.02,
                    //         // );
                    //       },
                    //       // likeCount: int.parse(widget.review.reportCount),
                    //       // countBuilder:
                    //       //     (int count, bool isLiked, String text) {
                    //       //   var color = isLiked ? Colors.white : Colors.grey;
                    //       //   Widget result;
                    //       //   if (count == 0) {
                    //       //     result = Text(
                    //       //       "Spoiler",
                    //       //       style: whiteTextFont.copyWith(fontSize: 12),
                    //       //     );
                    //       //   } else
                    //       //     result = Text(
                    //       //       text,
                    //       //       style: TextStyle(color: color),
                    //       //     );
                    //       //   return result;
                    //       // },
                    //     ),
                    //   ],
                    // ),

                    // Row(
                    //   children: [
                    //     Text(movie.voteAverage.toString(),
                    //         style: whiteTextFont),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Icon(Icons.star, color: Colors.amber)
                    //   ],
                    // )
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
