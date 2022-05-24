import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
