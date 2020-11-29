import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/genre.dart';
import '../repositories/movie_repository.dart';

class GetGenres extends UseCase<List<Genre>, NoParams> {
  final MovieRepository repository;

  GetGenres({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Genre>>> call(NoParams params) async {
    return await repository.getGenres();
  }
}
