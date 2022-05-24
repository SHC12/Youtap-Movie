import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
              RichText(
                text: TextSpan(text: 'YOUTAP ', style: whiteTextFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold), children: <TextSpan>[
                  TextSpan(
                    text: 'MOVIE',
                    style: redTextFont.copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  )
                ]),
              ),
            ],
          ),

          // GestureDetector(
          //   onTap: () {},
          //   child: SvgPicture.asset('assets/svg/avatar.svg', width: 13.w, color: yellowPrimary),
          // )
        ],
      ),
    );
  }
}
