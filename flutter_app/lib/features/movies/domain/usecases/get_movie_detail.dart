import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../entities/movie_detail.dart';
import '../params/get_movie_detail_params.dart';
import '../../../../core/error/exceptions.dart';
import '../repositories/movie_repository.dart';
import '../../../../core/usecases/usecase.dart';

class GetMovieDetail extends UseCase<MovieDetail, GetMovieDetailParams> {
  final MovieRepository repository;

  GetMovieDetail({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, MovieDetail>> call(
      GetMovieDetailParams params) async {
    return await repository.getMovieDetail(params.id);
  }
}
