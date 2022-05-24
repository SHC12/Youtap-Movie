import 'dart:io';

// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:youtap_movie/app/utils/url_list_services.dart';

class NetworkHelper {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: UrlListService.baseUrl,
      receiveTimeout: 10000, // 10 seconds
      sendTimeout: 10000,
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  /// Performs a GET request with [queryParameters]
  Future<T> get<T>({
    @required String? path,
    @required T Function(dynamic data)? onSuccess,
    @required T Function(dynamic error)? onError,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isRawResult = false,
  }) async {
    try {
      final response = await _client.get(
        path!,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data['results']);
    } on DioError catch (e) {
      print('${e.message} for ${UrlListService.baseUrl}$path');
      return onError!(e);
    } catch (e) {
      print(e.toString());
      return onError!(e);
    }
  }

  /// Performs a POST request with [body], then executes the functions
  /// with generic return value
  Future<T> post<T>({
    @required String? path,
    @required T Function(dynamic content)? onSuccess,
    @required T Function(dynamic error)? onError,
    @required Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
  }) async {
    try {
      _client.interceptors.add(LogInterceptor());
      final response = await _client.post(
        path!,
        data: containsFile ? FormData.fromMap(body!) : body,
        options: Options(
          contentType: containsFile ? Headers.formUrlEncodedContentType : Headers.jsonContentType,
        ),
      );

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data);
    } on DioError catch (e) {
      print('${e.message} for ${UrlListService.baseUrl}$path');
      return onError!(e);
    } catch (e) {
      print(e.toString());
      return onError!(e);
    }
  }

  /// Performs a Download File
  /// with generic return value
  Future<T> download<T>({
    @required String? path,
    T Function(dynamic content)? onSuccess,
    T Function(dynamic error)? onError,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
  }) async {
    try {
      _client.interceptors.add(LogInterceptor());
      final response = await _client.download(path!, '', options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}));

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data);
    } on DioError catch (e) {
      // print('${e.message} for ${UrlListService.baseUrl}$path');
      return onError!(e);
    } catch (e) {
      // print(e.toString());
      return onError!(e);
    }
  }

  /// Performs a PUT request with [body], then executes the functions
  /// with generic return value
  ///
  /// if the request contains a file, set [containsFile] to true
  Future<T> put<T>({
    @required String? path,
    @required T Function(dynamic content)? onSuccess,
    @required T Function(dynamic error)? onError,
    @required Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
  }) async {
    try {
      final response = await _client.put(
        path!,
        data: containsFile ? FormData.fromMap(body!) : body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data['content']);
    } on DioError catch (e) {
      print('${e.message} for ${UrlListService.baseUrl}$path');
      return onError!(e);
    } catch (e) {
      print(e.toString());
      return onError!(e);
    }
  }

  Future<T> delete<T>({
    @required String? path,
    @required T Function(dynamic content)? onSuccess,
    @required T Function(dynamic error)? onError,
    Map<String, dynamic>? headers,
    bool isRawResult = false,
  }) async {
    try {
      final response = await _client.delete(
        path!,
        options: Options(headers: headers),
      );

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data['content']);
    } on DioError catch (e) {
      print('${e.message} for ${UrlListService.baseUrl}$path');
      return onError!(e);
    } catch (e) {
      print(e.toString());
      return onError!(e);
    }
  }
}
