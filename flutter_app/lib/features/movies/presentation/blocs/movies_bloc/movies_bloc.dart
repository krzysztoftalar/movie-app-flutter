import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/params/get_movies_by_genre_params.dart';
import '../../../domain/params/get_movies_params.dart';
import '../../../domain/usecases/get_movies_by_genre.dart';
import '../../../domain/usecases/get_playing_now.dart';
import '../../../domain/usecases/get_upcoming.dart';
import '../../../domain/usecases/get_popular.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../domain/entities/movie.dart';

part 'movies_event.dart';
part 'movies_state.dart';

typedef Future<Either<ServerException, List<Movie>>> _GetMovies();

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPlayingNow getPlayingNow;
  final GetPopular getPopular;
  final GetUpcoming getUpcoming;
  final GetMoviesByGenre getMoviesByGenre;

  MoviesBloc({
    @required this.getPlayingNow,
    @required this.getPopular,
    @required this.getUpcoming,
    @required this.getMoviesByGenre,
  }) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
      MoviesEvent event,
      ) async* {
    if (event is GetMoviesEvent) {
      switch (event.predicate) {
        case MoviesFilter.All:
          switch (event.tabIndex) {
            case 0:
              yield* _moviesToState(
                  event, () => getPopular(GetMoviesParams(page: event.page)));
              break;
            case 1:
              yield* _moviesToState(
                  event, () => getPlayingNow(GetMoviesParams(page: event.page)));
              break;
            case 2:
              yield* _moviesToState(
                  event, () => getUpcoming(GetMoviesParams(page: event.page)));
              break;
          }
          break;
        case MoviesFilter.ByGenre:
          yield* _moviesToState(
            event,
                () => getMoviesByGenre(GetMoviesByGenreParams(
              id: event.genreId,
              page: event.page,
            )),
          );
          break;
      }
    }
  }

  Stream<MoviesState> _moviesToState(
      GetMoviesEvent event, _GetMovies _getMovies) async* {
    if (event.page == 1) {
      yield MoviesLoading();
    }
    final moviesEither = await _getMovies();
    yield moviesEither.fold(
          (failure) => MoviesError(message: failure.message),
          (movies) {
        if (event.page > 1) {
          final List<Movie> movieState =
          List.from((state as MoviesLoaded).movies)..addAll(movies);
          return MoviesLoaded(
            movies: movieState,
            page: event.page,
            genreId: event.genreId,
            tabIndex: event.tabIndex,
            predicate: event.predicate,
          );
        }
        return MoviesLoaded(
          movies: movies,
          page: event.page,
          genreId: event.genreId,
          tabIndex: event.tabIndex,
          predicate: event.predicate,
        );
      },
    );
  }
}
