import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_genres.dart';
import '../../../domain/entities/genre.dart';

part 'genre_event.dart';

part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GetGenres getGenres;

  GenreBloc({
    @required this.getGenres,
  }) : super(GenreInitial());

  @override
  Stream<GenreState> mapEventToState(
    GenreEvent event,
  ) async* {
    if (event is GetGenresEvent) {
      yield GenreLoading();
      final genresEither = await getGenres(NoParams());
      yield genresEither.fold(
        (failure) => GenreError(message: failure.message),
        (genres) => GenreLoaded(genres: genres),
      );
    }
  }
}
