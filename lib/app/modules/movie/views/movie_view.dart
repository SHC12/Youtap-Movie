import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/movie_controller.dart';

class MovieView extends GetView<MovieController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MovieView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
