part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final int genreId;
  final int page;
  final int tabIndex;
  final MoviesFilter predicate;

  MovieLoaded({
    @required this.movies,
    @required this.genreId,
    @required this.page,
    @required this.tabIndex,
    @required this.predicate,
  })  : assert(page >= 1, 'page cannot be less than 1'),
        assert(tabIndex >= 0, 'tabIndex cannot be less than 0');

  @override
  List<Object> get props => [movies, genreId, page, tabIndex, predicate];
}

class MovieError extends MovieState {
  final String message;

  MovieError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
