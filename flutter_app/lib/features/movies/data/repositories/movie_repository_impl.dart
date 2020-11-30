import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../models/movie_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/genre.dart';
import '../datasources/movie_remote_data_source.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

typedef Future<List<MovieModel>> _GetData();

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<ServerException, List<Movie>>> getPlayingNow(int page) async {
    return _getMovies(() => remoteDataSource.getPlayingNow(page));
  }

  @override
  Future<Either<ServerException, List<Movie>>> getPopular(int page) async {
    return _getMovies(() => remoteDataSource.getPopular(page));
  }

  @override
  Future<Either<ServerException, List<Movie>>> getUpcoming(int page) async {
    return _getMovies(() => remoteDataSource.getUpcoming(page));
  }

  @override
  Future<Either<ServerException, List<Movie>>> getMoviesByGenre(
      int id, int page) async {
    return _getMovies(() => remoteDataSource.getMoviesByGenre(id, page));
  }

  Future<Either<ServerException, List<Movie>>> _getMovies(
      _GetData _getData) async {
    try {
      final movies = await _getData();
      return Right(movies);
    } on ServerException catch (error) {
      return Left(ServerException(error.message));
    }
  }

  @override
  Future<Either<ServerException, List<Genre>>> getGenres() async {
    try {
      final genres = await remoteDataSource.getGenres();
      return Right(genres);
    } on ServerException catch (error) {
      return Left(ServerException(error.message));
    }
  }
}
