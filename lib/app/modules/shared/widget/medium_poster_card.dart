import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/data/movie_model.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class MediumPosterCard extends StatelessWidget {
  final Movie? movie;

  final Function()? onTap;
  MediumPosterCard({this.onTap, this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(UrlListService.baseUrlImageW500 + movie!.backdropPath!),
                            fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            movie!.title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: whiteTextFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          children: [
                            Text(movie!.voteAverage.toString(), style: whiteTextFont),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.star, color: Colors.amber)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
