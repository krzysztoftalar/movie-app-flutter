import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../repositories/movie_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../params/get_movies_params.dart';

class GetPopular extends UseCase<List<Movie>, GetMovieParams> {
  final MovieRepository repository;

  GetPopular({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Movie>>> call(GetMovieParams params) async {
    return await repository.getPopular(params.page);
  }
}

