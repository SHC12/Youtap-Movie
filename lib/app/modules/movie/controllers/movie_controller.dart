import 'package:get/get.dart';
import 'package:youtap_movie/app/data/movie_model.dart';
import 'package:youtap_movie/app/utils/network_helper.dart';
import 'package:youtap_movie/app/utils/url_list_services.dart';

class MovieController extends GetxController {
  var listNowPlaying = <Movie>[].obs;
  var listPopular = <Movie>[].obs;
  // var searchList = <Movie>[].obs;
  // var oldSearch = <Movie>[].obs;
  // var listRamaiReview = <Movie>[].obs;
  // var detailMovie = DetailMovie().obs;
  var isLoading = false.obs;
  var key = "".obs;
  var isMoreDataAvailable = true.obs;
  // var reviewController = Get.put(ReviewController());

  var network = Get.put(NetworkHelper());

  @override
  void onInit() {
    super.onInit();
    fetchNowPlaying();
  }

  fetchNowPlaying() async {
    isLoading(true);
    return network.get(
        path: UrlListService.urlNowPlayingMovie,
        queryParameters: {
          'api_key': '5bc459b70dbb68f19b8106667ecc57c8',
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
          'api_key': '5bc459b70dbb68f19b8106667ecc57c8',
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

  // fetchRamaiReview() async {
  //   isLoading(true);
  //   List<Movie> result = await MovieServices.getRamaiReview();
  //   listRamaiReview.assignAll(result);
  //   isLoading(false);
  // }

  // fetchDetailMovie(String movieId, {bool isNowPlaying = false}) async {
  //   DetailMovie result = await MovieServices.getDetailMovie(movieId);
  //   // print('asdasd' + result.id.toString());
  //   reviewController.fetchReviewMovie(result.id.toString());
  //   Get.to(DetailMoviePage(
  //     isNowPlaying: isNowPlaying,
  //   ));
  //   isLoading(true);

  //   detailMovie.value = result;
  //   if (detailMovie.value != null) {}
  //   isLoading(false);
  // }

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
