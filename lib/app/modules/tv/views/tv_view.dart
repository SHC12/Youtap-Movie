import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/home/views/widget/refresh_widget.dart';
import 'package:youtap_movie/app/modules/movie/views/widget/header_widget.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_large_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/item/shimmer_medium_poster.dart';
import 'package:youtap_movie/app/modules/shared/widget/large_poster_card.dart';
import 'package:youtap_movie/app/modules/shared/widget/medium_poster_card.dart';
import 'package:youtap_movie/app/modules/tv/controllers/tv_controller.dart';
import 'package:youtap_movie/app/modules/tv/views/popular_tv_view.dart';
import 'package:youtap_movie/app/modules/tv/views/tv_onair_view.dart';

class TvView extends StatefulWidget {
  const TvView({Key? key}) : super(key: key);

  @override
  State<TvView> createState() => _TvViewState();
}

class _TvViewState extends State<TvView> {
  TvController tvController = Get.put(TvController());

  @override
  void initState() {
    super.initState();
    tvController.fetchOnAir();
    tvController.fetchPopular();
  }

  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 400));
    tvController.fetchOnAir();
    tvController.fetchPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackPrimary,
        body: SafeArea(
            child: RefreshWidget(
          onRefresh: refresh,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                    child: SizedBox(
                      child: Text(
                        'Hello,' + ' Dedi Kurniawan',
                        style: whiteTextFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  TVOnAirView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  PopularTVView()
                ],
              ),
            ],
          ),
        )));
  }
}
