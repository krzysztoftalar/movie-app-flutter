import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/params/get_similar_movies_params.dart';
import '../../../domain/usecases/get_similar_movies.dart';

part 'similar_movies_event.dart';

part 'similar_movies_state.dart';

class SimilarMoviesBloc extends Bloc<SimilarMoviesEvent, SimilarMoviesState> {
  GetSimilarMovies getSimilarMovies;

  SimilarMoviesBloc({
    @required this.getSimilarMovies,
  }) : super(SimilarMoviesInitial());

  @override
  Stream<SimilarMoviesState> mapEventToState(
    SimilarMoviesEvent event,
  ) async* {
    if (event is GetSimilarMoviesEvent) {
      if (event.page == 1) {
        yield SimilarMoviesLoading();
      }

      final moviesEither = await getSimilarMovies(
          GetSimilarMoviesParams(id: event.movieId, page: event.page));
      yield moviesEither.fold(
        (failure) => SimilarMoviesError(message: failure.message),
        (movies) {
          if (event.page > 1) {
            final List<Movie> movieState =
                List.from((state as SimilarMoviesLoaded).movies)
                  ..addAll(movies);
            return SimilarMoviesLoaded(
              movies: movieState,
              page: event.page,
            );
          }
          return SimilarMoviesLoaded(
            movies: movies,
            page: event.page,
          );
        },
      );
    }
  }
}
