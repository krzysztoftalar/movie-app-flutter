import 'package:dartz/dartz.dart';

import '../entities/cast.dart';
import '../entities/movie_detail.dart';
import '../../../../core/error/exceptions.dart';
import '../entities/genre.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<ServerException, List<Movie>>> getPlayingNow(int page);
  Future<Either<ServerException, List<Movie>>> getPopular(int page);
  Future<Either<ServerException, List<Movie>>> getUpcoming(int page);
  Future<Either<ServerException, MovieDetail>> getMovieDetail(int id);
  Future<Either<ServerException, List<Movie>>> getMoviesByGenre(
      int id, int page);
  Future<Either<ServerException, List<Movie>>> getSimilarMovies(
      int id, int page);
  Future<Either<ServerException, List<Genre>>> getGenres();
  Future<Either<ServerException, List<Cast>>> getCastsForMovie(int id);
}
