import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../repositories/movie_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';
import '../params/get_movies_params.dart';

class GetPlayingNow extends UseCase<List<Movie>, GetMoviesParams> {
  final MovieRepository repository;

  GetPlayingNow({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Movie>>> call(GetMoviesParams params) async {
    return await repository.getPlayingNow(params.page);
  }
}

