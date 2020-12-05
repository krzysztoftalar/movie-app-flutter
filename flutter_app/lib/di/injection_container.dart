import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/movies/presentation/blocs/similar_movies/similar_movies_bloc.dart';
import '../features/movies/domain/usecases/get_similar_movies.dart';
import '../features/movies/presentation/blocs/casts_bloc/casts_bloc.dart';
import '../features/movies/domain/usecases/get_casts_for_movie.dart';
import '../features/movies/presentation/blocs/movie_bloc/movie_bloc.dart';
import '../features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import '../features/movies/domain/usecases/get_movie_detail.dart';
import '../features/movies/domain/usecases/get_upcoming.dart';
import '../features/movies/domain/usecases/get_popular.dart';
import '../features/movies/domain/usecases/get_movies_by_genre.dart';
import '../features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';
import '../features/movies/domain/usecases/get_genres.dart';
import '../features/movies/data/api/movie_api_client.dart';
import '../features/movies/data/datasources/movie_remote_data_source.dart';
import '../features/movies/domain/repositories/movie_repository.dart';
import '../features/movies/data/repositories/movie_repository_impl.dart';
import '../features/movies/domain/usecases/get_playing_now.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Movies
  // Bloc
  sl.registerFactory(
    () => MoviesBloc(
      getPlayingNow: sl(),
      getMoviesByGenre: sl(),
      getPopular: sl(),
      getUpcoming: sl(),
    ),
  );
  sl.registerFactory(() => MovieBloc(getMovieDetail: sl()));
  sl.registerFactory(() => GenreBloc(getGenres: sl()));
  sl.registerFactory(() => CastsBloc(getCastsForMovie: sl()));
  sl.registerFactory(
    () => SimilarMoviesBloc(getSimilarMovies: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPlayingNow(repository: sl()));
  sl.registerLazySingleton(() => GetPopular(repository: sl()));
  sl.registerLazySingleton(() => GetUpcoming(repository: sl()));
  sl.registerLazySingleton(() => GetMoviesByGenre(repository: sl()));
  sl.registerLazySingleton(() => GetSimilarMovies(repository: sl()));
  sl.registerLazySingleton(() => GetMovieDetail(repository: sl()));
  sl.registerLazySingleton(() => GetGenres(repository: sl()));
  sl.registerLazySingleton(() => GetCastsForMovie(repository: sl()));

  // Repositories
  sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));

  // Api
  sl.registerLazySingleton(() => MovieApiClient(client: sl()));

  // External
  sl.registerLazySingleton(() => Dio());
}
