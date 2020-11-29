import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/movies/presentation/blocs/genre_bloc/genre_bloc.dart';
import '../features/movies/domain/usecases/get_genres.dart';
import '../features/movies/data/api/movie_api_client.dart';
import '../features/movies/data/datasources/movie_remote_data_source.dart';
import '../features/movies/domain/repositories/movie_repository.dart';
import '../features/movies/data/repositories/movie_repository_impl.dart';
import '../features/movies/domain/usecases/get_playing_now.dart';
import '../features/movies/presentation/blocs/movie_bloc/movie_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Movies
  // Bloc
  sl.registerFactory(() => MovieBloc(getPlayingNow: sl()));
  sl.registerFactory(() => GenreBloc(getGenres: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPlayingNow(repository: sl()));
  sl.registerLazySingleton(() => GetGenres(repository: sl()));

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
