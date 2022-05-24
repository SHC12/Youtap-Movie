import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/home/views/home_view.dart';
import 'package:youtap_movie/app/modules/main/views/main_view.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({Key? key}) : super(key: key);

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  @override
  void initState() {
    super.initState();
    splashscreenStart();
  }

  splashscreenStart() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Get.offAll(MainView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: blackPrimary,
          ),
          SafeArea(
              child: Stack(
            children: [
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'YOUTAP ',
                            style: whiteTextFont.copyWith(fontSize: 30.sp, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'MOVIE',
                                style: redTextFont.copyWith(fontSize: 30.sp, fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
