import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:random_color/random_color.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackPrimary,
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(128),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/image/pattern_movie.jpg'), fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: SvgPicture.asset('assets/svg/avatar.svg',
                            height: 15.h, color: RandomColor().randomColor(colorBrightness: ColorBrightness.light)),
                      ),
                      Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(color: blackPrimary, borderRadius: BorderRadius.circular(8)),
                          child: Text('Dedi Kurniawan', style: whiteTextFont)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.25 - 75,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              width: double.infinity,
              color: blackPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {},
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 25, color: Colors.white),
                        SizedBox(width: 10),
                        Text('Logout',
                            style:
                                blackTextFont.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300))
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
