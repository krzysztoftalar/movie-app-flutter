import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import './movie_api_constants.dart';

class MovieApiClient {
  final Dio client;

  MovieApiClient({
    @required this.client,
  });

  dynamic get(String path,
      [List<Map<String, Object>> paramsList = const []]) async {
    Map<String, Object> params = {
      "api_key": ApiConstants.MOVIE_API_KEY,
    };

    if (paramsList.isNotEmpty) {
      paramsList.forEach((param) {
        params.addAll(param);
      });
    }

    try {
      final response = await client.get(
        '${ApiConstants.MOVIE_API_URL}$path',
        queryParameters: params,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (error) {
      throw ServerException(SERVER_FAILURE_MESSAGE);
    }
  }
}
