import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/params/get_casts_for_movie_params.dart';
import '../../../domain/usecases/get_casts_for_movie.dart';
import '../../../domain/entities/cast.dart';

part 'casts_event.dart';

part 'casts_state.dart';

class CastsBloc extends Bloc<CastsEvent, CastsState> {
  final GetCastsForMovie getCastsForMovie;

  CastsBloc({
    @required this.getCastsForMovie,
  }) : super(CastsInitial());

  @override
  Stream<CastsState> mapEventToState(
    CastsEvent event,
  ) async* {
    if (event is GetCastsForMovieEvent) {
      yield CastsLoading();
      final castsEither =
          await getCastsForMovie(GetCastsForMovieParams(id: event.movieId));
      yield castsEither.fold(
        (failure) => CastsError(message: failure.message),
        (casts) => CastsLoaded(casts: casts),
      );
    }
  }
}
