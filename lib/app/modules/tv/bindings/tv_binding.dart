import 'package:get/get.dart';
import 'package:youtap_movie/app/modules/tv/controllers/tv_controller.dart';

class MovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TvController>(
      () => TvController(),
    );
  }
}
