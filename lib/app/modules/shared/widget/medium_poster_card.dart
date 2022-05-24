import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class MediumPosterCard extends StatelessWidget {
  final String? poster;
  final String? vote;
  final String? title;

  final Function()? onTap;
  MediumPosterCard({this.onTap, this.poster, this.vote, this.title});

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
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: DecorationImage(image: NetworkImage(UrlListService.baseUrlImageW500 + poster!), fit: BoxFit.fill)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(
                            title!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: whiteTextFont.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Row(
                          children: [
                            Text(vote.toString(), style: whiteTextFont),
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
