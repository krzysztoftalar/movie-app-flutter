import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_playing_now.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetPlayingNow getPlayingNow;

  MovieBloc({
    @required this.getPlayingNow,
  }) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is GetPlayingNowEvent) {
      yield* _mapMoviesLoadedToState(event);
    }
  }

  Stream<MovieState> _mapMoviesLoadedToState(GetPlayingNowEvent event) async* {
    if (event.page == 1) {
      yield MovieLoading();
    }
    final moviesEither = await getPlayingNow(Params(page: event.page));
    yield moviesEither.fold(
      (failure) => MovieError(message: failure.message),
      (movies) {
        if (event.page > 1) {
          final List<Movie> movieState =
              List.from((state as MovieLoaded).movies)..addAll(movies);
          return MovieLoaded(movies: movieState, page: event.page);
        }
        return MovieLoaded(movies: movies, page: event.page);
      },
    );
  }
}
