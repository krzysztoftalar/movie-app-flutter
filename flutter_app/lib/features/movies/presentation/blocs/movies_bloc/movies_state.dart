part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  final MoviesFilter predicate;
  final int genreId;
  final int page;
  final int tabIndex;

  MoviesLoaded({
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

class MoviesError extends MoviesState {
  final String message;

  MoviesError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
