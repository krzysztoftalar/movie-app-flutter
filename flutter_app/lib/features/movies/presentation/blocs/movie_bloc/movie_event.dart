part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetPlayingNowEvent extends MovieEvent {
  final int page;

  GetPlayingNowEvent({
    this.page = 1,
  }) : assert(page >= 1, 'page cannot be less than 1');

  @override
  List<Object> get props => [page];
}
