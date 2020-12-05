import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/cast.dart';
import '../../domain/entities/movie_detail.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/genre.dart';
import '../datasources/movie_remote_data_source.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

typedef Future<List<T>> _GetRemoteData<T>();

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<ServerException, List<Movie>>> getPlayingNow(int page) async {
    return _getData(() => remoteDataSource.getPlayingNow(page));
  }

  @override
  Future<Either<ServerException, List<Movie>>> getPopular(int page) async {
    return _getData(() => remoteDataSource.getPopular(page));
  }

  @override
  Future<Either<ServerException, List<Movie>>> getUpcoming(int page) async {
    return _getData(() => remoteDataSource.getUpcoming(page));
  }

  @override
  Future<Either<ServerException, List<Movie>>> getMoviesByGenre(
      int id, int page) async {
    return _getData(() => remoteDataSource.getMoviesByGenre(id, page));
  }

  @override
  Future<Either<ServerException, List<Movie>>> getSimilarMovies(
      int id, int page) async {
    return _getData(() => remoteDataSource.getSimilarMovies(id, page));
  }

  @override
  Future<Either<ServerException, List<Genre>>> getGenres() async {
    return _getData(() => remoteDataSource.getGenres());
  }

  @override
  Future<Either<ServerException, List<Cast>>> getCastsForMovie(int id) async {
    return _getData(() => remoteDataSource.getCastsForMovie(id));
  }

  @override
  Future<Either<ServerException, MovieDetail>> getMovieDetail(int id) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(id);
      return Right(movie);
    } on ServerException catch (error) {
      return Left(ServerException(error.message));
    }
  }

  Future<Either<ServerException, List<T>>> _getData<T>(
      _GetRemoteData _getRemoteData) async {
    try {
      final data = await _getRemoteData();
      return Right(data);
    } on ServerException catch (error) {
      return Left(ServerException(error.message));
    }
  }
}
