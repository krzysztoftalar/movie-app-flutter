import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../params/get_casts_for_movie_params.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/cast.dart';
import '../repositories/movie_repository.dart';

class GetCastsForMovie extends UseCase<List<Cast>, GetCastsForMovieParams> {
  final MovieRepository repository;

  GetCastsForMovie({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Cast>>> call(
      GetCastsForMovieParams params) async {
    return await repository.getCastsForMovie(params.id);
  }
}
