import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import "../../../domain/entities/movie_detail.dart";
import '../../../domain/params/get_movie_detail_params.dart';
import '../../../domain/usecases/get_movie_detail.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetail getMovieDetail;

  MovieBloc({
    @required this.getMovieDetail,
  }) : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is GetMovieDetailEvent) {
      yield MovieLoading();
      final movieEither =
          await getMovieDetail(GetMovieDetailParams(id: event.movieId));
      yield movieEither.fold(
        (failure) => MovieError(message: failure.message),
        (movie) => MovieLoaded(movie: movie),
      );
    }
  }
}
