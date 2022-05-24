import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class LargePosterCard extends StatelessWidget {
  final String image;
  final Function()? onTap;
  LargePosterCard(this.image, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Hero(
        tag: 'large-poster-' + image,
        child: image == ""
            ? Container(
                color: Colors.grey,
                height: 3.h,
                child: Center(
                  child: Text(
                    'NO POSTER',
                    style: whiteTextFont.copyWith(fontSize: Get.height * 0.02),
                  ),
                ),
              )
            : Container(
                height: 3.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  UrlListService.baseUrlImage + image,
                ),
              ),
      ),
    );
  }
}
