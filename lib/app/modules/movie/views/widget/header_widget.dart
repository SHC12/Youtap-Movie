import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                child: Text(
                  'Hello,' + ' Dedi Kurniawan',
                  style: whiteTextFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset('assets/svg/avatar.svg', width: 13.w, color: yellowPrimary),
          )
        ],
      ),
    );
  }
}
