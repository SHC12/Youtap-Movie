import 'package:get/get.dart';
import 'package:youtap_movie/app/data/review_movie_model.dart';
import 'package:youtap_movie/app/utils/network_helper.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class ReviewController extends GetxController {
  var reviewMovie = ReviewMovie().obs;
  var network = Get.put(NetworkHelper());

  var listReviewMovie = <ReviewMovie>[].obs;

  var isLoading = false.obs;

  fetchReview(String movieId) async {
    return network.get(
        path: UrlListService.baseUrl + movieId + '/reviews',
        queryParameters: {'api_key': '5bc459b70dbb68f19b8106667ecc57c8', 'language': 'en-US'},
        onSuccess: (content) {
          print('response : $content');
          List<ReviewMovie> result = (content as Iterable).map((e) => ReviewMovie.fromJson(e)).toList();
          listReviewMovie.assignAll(result);
        },
        onError: (content) {
          print('error : $content');
        });
  }
}
