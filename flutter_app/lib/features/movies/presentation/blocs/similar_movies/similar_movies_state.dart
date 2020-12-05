part of 'similar_movies_bloc.dart';

abstract class SimilarMoviesState extends Equatable {
  const SimilarMoviesState();

  @override
  List<Object> get props => [];
}

class SimilarMoviesInitial extends SimilarMoviesState {}

class SimilarMoviesLoading extends SimilarMoviesState {}

class SimilarMoviesLoaded extends SimilarMoviesState {
  final List<Movie> movies;
  final int page;

  SimilarMoviesLoaded({
    @required this.movies,
    @required this.page,
  }) : assert(page >= 1, 'page cannot be less than 1');

  @override
  List<Object> get props => [movies, page];
}

class SimilarMoviesError extends SimilarMoviesState {
  final String message;

  SimilarMoviesError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
