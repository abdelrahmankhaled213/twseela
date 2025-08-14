import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:twseela/core/Error/exception.dart';


import 'api_service.dart';

class DioConsumer extends ApiConsumer {

  final Dio dio;

  DioConsumer({required this.dio});

  @override
  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {


  }

  @override
  Future get(String path, {Object? data
    , Map<String, dynamic>? queryParameters}) async {
    try {



      final response = await dio.
      get(path, queryParameters: queryParameters,
          data: data
      );

      return response.data;
    }

    on DioException catch (e) {

      handleDioError(e);
    }
  }

  @override
  Future post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future put(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) {
    // TODO: implement put
    throw UnimplementedError();
  }

}