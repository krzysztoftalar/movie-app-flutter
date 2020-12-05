part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final MovieDetail movie;

  MovieLoaded({
    @required this.movie,
  });

  @override
  List<Object> get props => [movie];
}

class MovieError extends MovieState {
  final String message;

  MovieError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
