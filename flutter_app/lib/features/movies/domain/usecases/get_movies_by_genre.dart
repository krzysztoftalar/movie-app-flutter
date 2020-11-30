import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../params/get_movies_by_genre_params.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/movie_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';

class GetMoviesByGenre extends UseCase<List<Movie>, GetMoviesByGenreParams> {
  final MovieRepository repository;

  GetMoviesByGenre({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Movie>>> call(GetMoviesByGenreParams params) async {
    return await repository.getMoviesByGenre(params.id, params.page);
  }
}


