import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    LayoutBuilder(builder: (context, constraints) {
      return Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            theme: ThemeData(
              textTheme: GoogleFonts.quicksandTextTheme(
                Theme.of(context).textTheme,
              ),
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        },
      );
    }),
  );
}
