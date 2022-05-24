import 'package:get/get.dart';
import 'package:youtap_movie/app/data/credits_movie_model.dart';
import 'package:youtap_movie/app/data/detail_movie_model.dart';
import 'package:youtap_movie/app/data/detail_tv.dart';
import 'package:youtap_movie/app/data/movie_model.dart';
import 'package:youtap_movie/app/data/tv_model.dart';
import 'package:youtap_movie/app/modules/movie/controllers/review_controller.dart';
import 'package:youtap_movie/app/modules/movie/views/detail_movie_view.dart';
import 'package:youtap_movie/app/modules/tv/views/detail_tv_view.dart';
import 'package:youtap_movie/app/utils/network_helper.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class TvController extends GetxController {
  var listTvOnAIr = <Tv>[].obs;
  var listTvPopular = <Tv>[].obs;
  var listCredits = CreditsMovie().obs;

  var detailTv = DetailTv().obs;
  var isLoading = false.obs;
  var key = "".obs;
  var isMoreDataAvailable = true.obs;
  var reviewController = Get.put(ReviewController());

  var network = Get.put(NetworkHelper());

  @override
  void onInit() {
    super.onInit();
    fetchOnAir();
  }

  fetchOnAir() async {
    isLoading(true);
    return network.get(
        path: UrlListService.urlTvOnAir,
        queryParameters: {
          'api_key': '5bc459b70dbb68f19b8106667ecc57c8',
          'language': 'en-US',
          'page': '1',
        },
        onSuccess: (content) {
          print('response : $content');
          List<Tv> result = (content as Iterable).map((e) => Tv.fromJson(e)).toList();

          listTvOnAIr.assignAll(result);
          isLoading(false);
        },
        onError: (content) {
          print('error : $content');
        });
  }

  fetchPopular() async {
    isLoading(true);
    return network.get(
        path: UrlListService.urlTvPopular,
        queryParameters: {
          'api_key': '5bc459b70dbb68f19b8106667ecc57c8',
          'language': 'en-US',
          'page': '1',
        },
        onSuccess: (content) {
          print('response : $content');
          List<Tv> result = (content as Iterable).map((e) => Tv.fromJson(e)).toList();

          listTvPopular.assignAll(result);
          isLoading(false);
        },
        onError: (content) {
          print('error : $content');
        });
  }

  // fetchUpcoming() async {
  //   isLoading(true);
  //   return network.get(
  //       path: UrlListService.urlUpcomingMovie,
  //       queryParameters: {
  //         'api_key': '5bc459b70dbb68f19b8106667ecc57c8',
  //         'language': 'en-US',
  //         'page': '1',
  //       },
  //       onSuccess: (content) {
  //         print('response : $content');
  //         List<Movie> result = (content as Iterable).map((e) => Movie.fromJson(e)).toList();

  //         listUpcoming.assignAll(result.where((element) => element.posterPath != ""));
  //         isLoading(false);
  //       },
  //       onError: (content) {
  //         print('error : $content');
  //       });
  // }

  fetchDetailTv(String tvId, {bool isNowPlaying = false}) async {
    return network.get(
        path: UrlListService.baseUrl + "tv/${tvId}",
        isRawResult: true,
        queryParameters: {'api_key': '5bc459b70dbb68f19b8106667ecc57c8', 'language': 'en-US'},
        onSuccess: (content) async {
          print('response : $content');

          await network.get(
              path: UrlListService.baseUrl + "tv/${tvId}" + '/credits',
              queryParameters: {'api_key': '5bc459b70dbb68f19b8106667ecc57c8', 'language': 'en-US'},
              isRawResult: true,
              onSuccess: (credit) {
                print('credits response : $credit');
                listCredits.value = CreditsMovie.fromJson(credit);
                detailTv.value = DetailTv.fromJson(content);
                reviewController.fetchReviewTv(tvId);

                Get.to(DetailTvView());
              },
              onError: (credit) {
                print('credits error : $credit');
              });
        },
        onError: (content) {
          print('error : $content');
        });
    // DetailMovie result = await MovieServices.getDetailMovie(movieId);
    // // print('asdasd' + result.id.toString());
    // reviewController.fetchReviewMovie(result.id.toString());
    // Get.to(DetailMovieView(
    //   isNowPlaying: isNowPlaying,
    // ));
    // isLoading(true);

    // detailMovie.value = result;
    // if (detailMovie.value != null) {}
    // isLoading(false);
  }

  // // getSearchMovie(String keywordSearch, int page) async {
  // //   try {
  // //     isMoreDataAvailable(false);
  // //     isLoading(true);

  // //     if (key.value != keywordSearch) {
  // //       searchList.clear();
  // //     }
  // //     key.value = keywordSearch;
  // //     print(key.value);

  // //     await MovieServices.searchMovie(keywordSearch, page).then((resp) {
  // //       isLoading(false);
  // //       searchList.addAll(resp.where((element) => element.posterPath != ""));
  // //     }, onError: (err) {
  // //       isLoading(false);
  // //     });
  // //   } catch (exception) {
  // //     print(exception);
  // //     isLoading(false);
  // //   }
  // // }

  // // void getMoreMovie(String keywordSearch, int page) async {
  // //   try {
  // //     isLoading(true);
  // //     getSearchMovie(keywordSearch, page);
  // //   } catch (exception) {
  // //     isLoading(false);

  // //     isMoreDataAvailable(false);
  // //     Get.snackbar('Exception', exception,
  // //         margin: EdgeInsets.all(12),
  // //         backgroundColor: Colors.white60,
  // //         snackPosition: SnackPosition.BOTTOM);
  // //   }
  // // }
}
