import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../params/get_similar_movies_params.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/movie_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';

class GetSimilarMovies extends UseCase<List<Movie>, GetSimilarMoviesParams> {
  final MovieRepository repository;

  GetSimilarMovies({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Movie>>> call(
      GetSimilarMoviesParams params) async {
    return await repository.getSimilarMovies(params.id, params.page);
  }
}
