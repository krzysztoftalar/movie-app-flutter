import 'package:flutter/foundation.dart';

import '../models/cast_result_model.dart';
import '../models/cast_model.dart';
import '../models/movie_detail_model.dart';
import '../../../../core/error/exceptions.dart';
import '../models/genre_model.dart';
import '../models/genre_result_model.dart';
import '../api/movie_api_client.dart';
import '../models/movie_result_model.dart';
import '../models/movie_model.dart';

typedef Future<dynamic> _MovieApiClient();

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPlayingNow(int page);

  Future<List<MovieModel>> getPopular(int page);

  Future<List<MovieModel>> getUpcoming(int page);

  Future<List<MovieModel>> getMoviesByGenre(int id, int page);

  Future<List<MovieModel>> getSimilarMovies(int id, int page);

  Future<MovieDetailModel> getMovieDetail(int id);

  Future<List<GenreModel>> getGenres();

  Future<List<CastModel>> getCastsForMovie(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final MovieApiClient client;

  MovieRemoteDataSourceImpl({
    @required this.client,
  });

  Future<List<MovieModel>> _getMoviesFromApi(
      _MovieApiClient _movieApiClient) async {
    try {
      final response = await _movieApiClient();
      return MovieResultModel.fromJson(response).movies;
    } on ServerException catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<MovieModel>> getPlayingNow(int page) async {
    var params = [
      {
        "page": page,
      }
    ];
    return _getMoviesFromApi(() => client.get('/movie/now_playing', params));
  }

  @override
  Future<List<MovieModel>> getPopular(int page) async {
    var params = [
      {
        "page": page,
      }
    ];
    return _getMoviesFromApi(() => client.get('/movie/popular', params));
  }

  @override
  Future<List<MovieModel>> getUpcoming(int page) async {
    var params = [
      {
        "page": page,
      }
    ];
    return _getMoviesFromApi(() => client.get('/movie/upcoming', params));
  }

  @override
  Future<List<MovieModel>> getMoviesByGenre(int id, int page) async {
    var params = [
      {
        "page": page,
        "with_genres": id,
      }
    ];
    return _getMoviesFromApi(() => client.get('/discover/movie', params));
  }

  @override
  Future<List<MovieModel>> getSimilarMovies(int id, int page) async {
    var params = [
      {
        "page": page,
      }
    ];
    return _getMoviesFromApi(() => client.get('/movie/$id/similar', params));
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    try {
      final response = await client.get('/movie/$id');
      return MovieDetailModel.fromJson(response);
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

  @override
  Future<List<CastModel>> getCastsForMovie(int id) async {
    try {
      final response = await client.get('/movie/$id/credits');
      return CastResultModel.fromJson(response).casts;
    } on ServerException catch (error) {
      throw ServerException(error.message);
    }
  }
}
