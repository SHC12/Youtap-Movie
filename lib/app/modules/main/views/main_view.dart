import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import 'package:sizer/sizer.dart';
import 'package:youtap_movie/app/modules/home/views/home_view.dart';
import 'package:youtap_movie/app/modules/shared/colors.dart';
import 'package:youtap_movie/app/modules/shared/fonts.dart';

import '../controllers/main_controller.dart';

class MainView extends StatefulWidget {
  final int? bottomNavBarIndex;
  final List? modul;

  MainView({this.bottomNavBarIndex = 0, this.modul});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  PageController? pageController;

  TabController? _tabController;

  var role;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.bottomNavBarIndex!;
    pageController = PageController(initialPage: _currentIndex);
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController?.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }

  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  late ThemeData themeData;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBody: true,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: BottomAppBar(
              elevation: 0,
              shape: CircularNotchedRectangle(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(top: 12, bottom: 12),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: whitePrimary,
                  tabs: <Widget>[
                    Container(
                      child: (_currentIndex == 0)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Remix.movie_2_fill,
                                  color: whitePrimary,
                                ),
                                Text('Movie', style: whiteTextFont.copyWith(fontSize: 10.sp, color: whitePrimary))
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Remix.movie_2_fill,
                                  color: yellowPrimary,
                                ),
                                Text('Movie', style: whiteTextFont.copyWith(fontSize: 10.sp, color: yellowPrimary))
                              ],
                            ),
                    ),
                    Container(
                      child: (_currentIndex == 1)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Remix.tv_fill,
                                  color: whitePrimary,
                                ),
                                Text('TV', style: whiteTextFont.copyWith(fontSize: 10.sp, color: whitePrimary))
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Remix.tv_fill,
                                  color: yellowPrimary,
                                ),
                                Text('TV', style: whiteTextFont.copyWith(fontSize: 10.sp, color: yellowPrimary))
                              ],
                            ),
                    ),
                    Container(
                      child: (_currentIndex == 2)
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Remix.user_fill,
                                  color: whitePrimary,
                                ),
                                Text('Profile', style: whiteTextFont.copyWith(fontSize: 10.sp, color: whitePrimary))
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Remix.user_fill,
                                  color: yellowPrimary,
                                ),
                                Text('Profile', style: whiteTextFont.copyWith(fontSize: 10.sp, color: yellowPrimary))
                              ],
                            ),
                    ),
                  ],
                ),
              )),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            HomeView(),
            HomeView(),
            HomeView(),
          ],
        ),
      ),
    );
  }
}
