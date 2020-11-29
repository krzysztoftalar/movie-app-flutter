import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../entities/genre.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<ServerException, List<Movie>>> getPlayingNow(int page);
  Future<Either<ServerException, List<Genre>>> getGenres();
}
