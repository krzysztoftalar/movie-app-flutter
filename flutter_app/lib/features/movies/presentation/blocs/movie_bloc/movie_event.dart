part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MovieEvent {
  final int page;
  final int genreId;
  final int tabIndex;
  final MoviesFilter predicate;

  GetMoviesEvent({
    this.page = 1,
    this.genreId,
    this.tabIndex = 1,
    this.predicate,
  })  : assert(page >= 1, 'page cannot be less than 1'),
        assert(tabIndex >= 0, 'tabIndex cannot be less than 0');

  @override
  List<Object> get props => [page, genreId, tabIndex, predicate];
}

enum MoviesFilter {
  ByGenre,
  All,
}
