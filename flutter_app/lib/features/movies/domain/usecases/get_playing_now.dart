import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../repositories/movie_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.dart';

class GetPlayingNow extends UseCase<List<Movie>, Params> {
  final MovieRepository repository;

  GetPlayingNow({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, List<Movie>>> call(Params params) async {
    return await repository.getPlayingNow(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({@required this.page});

  @override
  List<Object> get props => [page];
}
