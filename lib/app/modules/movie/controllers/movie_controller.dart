import 'package:get/get.dart';
import 'package:youtap_movie/app/data/config/constant.dart';
import 'package:youtap_movie/app/data/credits_movie_model.dart';
import 'package:youtap_movie/app/data/detail_movie_model.dart';
import 'package:youtap_movie/app/data/movie_model.dart';
import 'package:youtap_movie/app/modules/movie/controllers/review_controller.dart';
import 'package:youtap_movie/app/modules/movie/views/detail_movie_view.dart';
import 'package:youtap_movie/app/utils/network_helper.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class MovieController extends GetxController {
  var listNowPlaying = <Movie>[].obs;
  var listPopular = <Movie>[].obs;
  var listUpcoming = <Movie>[].obs;
  var listCredits = CreditsMovie().obs;

  var detailMovie = DetailMovie().obs;
  var isLoading = false.obs;
  var key = "".obs;
  var isMoreDataAvailable = true.obs;

  ReviewController reviewController = Get.put(ReviewController());
  var network = Get.put(NetworkHelper());

  fetchNowPlaying() async {
    isLoading(true);
    return network.get(
        path: UrlListService.urlNowPlayingMovie,
        queryParameters: {
          'api_key': Constant.apiKey,
          'language': 'en-US',
          'page': '1',
        },
        onSuccess: (content) {
          print('response : $content');
          List<Movie> result = (content as Iterable).map((e) => Movie.fromJson(e)).toList();

          listNowPlaying.assignAll(result.where((element) => element.posterPath != ""));
          isLoading(false);
        },
        onError: (content) {
          print('error : $content');
        });
  }

  fetchPopular() async {
    isLoading(true);
    return network.get(
        path: UrlListService.urlPopularMovie,
        queryParameters: {
          'api_key': Constant.apiKey,
          'language': 'en-US',
          'page': '1',
        },
        onSuccess: (content) {
          print('response : $content');
          List<Movie> result = (content as Iterable).map((e) => Movie.fromJson(e)).toList();

          listPopular.assignAll(result.where((element) => element.posterPath != ""));
          isLoading(false);
        },
        onError: (content) {
          print('error : $content');
        });
  }

  fetchUpcoming() async {
    isLoading(true);
    return network.get(
        path: UrlListService.urlUpcomingMovie,
        queryParameters: {
          'api_key': Constant.apiKey,
          'language': 'en-US',
          'page': '1',
        },
        onSuccess: (content) {
          print('response : $content');
          List<Movie> result = (content as Iterable).map((e) => Movie.fromJson(e)).toList();

          listUpcoming.assignAll(result.where((element) => element.posterPath != ""));
          isLoading(false);
        },
        onError: (content) {
          print('error : $content');
        });
  }

  fetchDetailMovie(String movieId, {bool isNowPlaying = false}) async {
    return network.get(
        path: UrlListService.baseUrl + 'movie/' + movieId,
        isRawResult: true,
        queryParameters: {'api_key': Constant.apiKey, 'language': 'en-US'},
        onSuccess: (content) async {
          print('response : $content');

          await network.get(
              path: UrlListService.baseUrl + 'movie/' + movieId + '/credits',
              queryParameters: {'api_key': Constant.apiKey, 'language': 'en-US'},
              isRawResult: true,
              onSuccess: (credit) {
                print('credits response : $credit');
                listCredits.value = CreditsMovie.fromJson(credit);
                detailMovie.value = DetailMovie.fromJson(content);
                reviewController.fetchReviewMovie(movieId);

                Get.to(DetailMovieView());
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

  // getSearchMovie(String keywordSearch, int page) async {
  //   try {
  //     isMoreDataAvailable(false);
  //     isLoading(true);

  //     if (key.value != keywordSearch) {
  //       searchList.clear();
  //     }
  //     key.value = keywordSearch;
  //     print(key.value);

  //     await MovieServices.searchMovie(keywordSearch, page).then((resp) {
  //       isLoading(false);
  //       searchList.addAll(resp.where((element) => element.posterPath != ""));
  //     }, onError: (err) {
  //       isLoading(false);
  //     });
  //   } catch (exception) {
  //     print(exception);
  //     isLoading(false);
  //   }
  // }

  // void getMoreMovie(String keywordSearch, int page) async {
  //   try {
  //     isLoading(true);
  //     getSearchMovie(keywordSearch, page);
  //   } catch (exception) {
  //     isLoading(false);

  //     isMoreDataAvailable(false);
  //     Get.snackbar('Exception', exception,
  //         margin: EdgeInsets.all(12),
  //         backgroundColor: Colors.white60,
  //         snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
}
