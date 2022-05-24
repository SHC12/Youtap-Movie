import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ShimmerCarouselLargePoster extends StatefulWidget {
  const ShimmerCarouselLargePoster({Key? key}) : super(key: key);

  @override
  State<ShimmerCarouselLargePoster> createState() => _ShimmerLargePosterState();
}

class _ShimmerLargePosterState extends State<ShimmerCarouselLargePoster> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (context, index, relIdx) {
          return Container(
            margin: EdgeInsets.only(left: (index == 0) ? 0 : 0, right: (index == 3 - 1) ? 20 : 16),
            child: Container(
              decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          );
        },
        options: CarouselOptions(
          height: 30.h,
          viewportFraction: 0.5,
          enableInfiniteScroll: true,
          disableCenter: true,
          enlargeCenterPage: false,
          initialPage: 0,
          onPageChanged: (index, reason) {},
          scrollDirection: Axis.horizontal,
        ),
      ),
      baseColor: Colors.white60,
      highlightColor: Colors.grey[300]!,
    );
  }
}
