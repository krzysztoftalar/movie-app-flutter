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
  final int page;

  MovieLoaded({
    @required this.movies,
    @required this.page,
  }) : assert(page >= 1, 'page cannot be less than 1');

  @override
  List<Object> get props => [movies, page];
}

class MovieError extends MovieState {
  final String message;

  MovieError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
