import 'package:get/get.dart';
import 'package:youtap_movie/app/data/review_movie_model.dart';
import 'package:youtap_movie/app/utils/network_helper.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class ReviewController extends GetxController {
  var review = Review().obs;
  var network = Get.put(NetworkHelper());

  var listReviewMovie = <Review>[].obs;

  var isLoading = false.obs;

  fetchReviewMovie(String movieId) async {
    return network.get(
        path: UrlListService.baseUrl + movieId + '/reviews',
        queryParameters: {'api_key': '5bc459b70dbb68f19b8106667ecc57c8', 'language': 'en-US'},
        onSuccess: (content) {
          print('response : $content');
          List<Review> result = (content as Iterable).map((e) => Review.fromJson(e)).toList();
          listReviewMovie.assignAll(result);
        },
        onError: (content) {
          print('error : $content');
        });
  }

  fetchReviewTv(String tvId) async {
    return network.get(
        path: UrlListService.baseUrl + 'tv/' + tvId + '/reviews',
        queryParameters: {'api_key': '5bc459b70dbb68f19b8106667ecc57c8', 'language': 'en-US'},
        onSuccess: (content) {
          print('response : $content');
          List<Review> result = (content as Iterable).map((e) => Review.fromJson(e)).toList();
          listReviewMovie.assignAll(result);
        },
        onError: (content) {
          print('error : $content');
        });
  }
}
