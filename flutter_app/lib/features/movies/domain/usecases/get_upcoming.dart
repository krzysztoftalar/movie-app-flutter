import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../repositories/movie_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../params/get_movies_params.dart';

class GetUpcoming extends UseCase<List<Movie>, GetMoviesParams> {
  final MovieRepository repository;

  GetUpcoming({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Movie>>> call(GetMoviesParams params) async {
    return await repository.getUpcoming(params.page);
  }
}

