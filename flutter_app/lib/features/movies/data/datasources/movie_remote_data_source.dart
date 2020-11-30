import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../models/genre_model.dart';
import '../models/genre_result_model.dart';
import '../api/movie_api_client.dart';
import '../models/movie_result_model.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPlayingNow(int page);
  Future<List<MovieModel>> getPopular(int page);
  Future<List<MovieModel>> getUpcoming(int page);
  Future<List<MovieModel>> getMoviesByGenre(int id, int page);
  Future<List<GenreModel>> getGenres();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final MovieApiClient client;

  MovieRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<List<MovieModel>> getPlayingNow(int page) async {
    try {
      var params = [
        {
          "page": page,
        }
      ];
      final response = await client.get('/movie/now_playing', params);
      return MovieResultModel.fromJson(response).movies;
    } on ServerException catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<MovieModel>> getPopular(int page) async {
    try {
      var params = [
        {
          "page": page,
        }
      ];
      final response = await client.get('/movie/popular', params);
      return MovieResultModel.fromJson(response).movies;
    } on ServerException catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming(int page) async {
    try {
      var params = [
        {
          "page": page,
        }
      ];
      final response = await client.get('/movie/upcoming', params);
      return MovieResultModel.fromJson(response).movies;
    } on ServerException catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(int id, int page) async {
    try {
      var params = [
        {
          "page": page,
          "with_genres": id,
        }
      ];
      final response = await client.get('/discover/movie', params);
      return MovieResultModel.fromJson(response).movies;
    } on ServerException catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    try {
      final response = await client.get('/genre/movie/list');
      return GenreResultModel.fromJson(response).genres;
    } on ServerException catch (error) {
      throw ServerException(error.message);
    }
  }
}
