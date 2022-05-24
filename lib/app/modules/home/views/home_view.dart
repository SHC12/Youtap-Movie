import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/movie/controllers/movie_controller.dart';
import 'package:youtap_movie/app/modules/movie/views/now_playing_view.dart';
import 'package:youtap_movie/app/modules/movie/views/popular_movie_view.dart';
import 'package:youtap_movie/app/modules/movie/views/upcoming_movie_view.dart';
import 'package:youtap_movie/app/modules/movie/views/widget/header_widget.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';
import 'package:youtap_movie/app/modules/shared/widget/large_poster_card.dart';
import 'package:youtap_movie/app/modules/shared/widget/medium_poster_card.dart';

import '../controllers/home_controller.dart';
import 'widget/refresh_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  MovieController movieController = Get.put(MovieController());
  TextEditingController tSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    movieController.fetchNowPlaying();
    movieController.fetchPopular();
    movieController.fetchUpcoming();
  }

  Future refresh() async {
    await Future.delayed(Duration(milliseconds: 400));
    movieController.fetchNowPlaying();
    movieController.fetchPopular();
    movieController.fetchUpcoming();
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
                  NowPlayingView(),
                  SizedBox(
                    height: 2.h,
                  ),
                  PopularMovieView(),
                  UpcomingMovieView()
                ],
              ),
            ],
          ),
        )));
  }
}
