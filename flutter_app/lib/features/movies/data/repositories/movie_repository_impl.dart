import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/genre.dart';
import '../datasources/movie_remote_data_source.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<ServerException, List<Movie>>> getPlayingNow(int page) async {
    try {
      final movies = await remoteDataSource.getPlayingNow(page);
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
