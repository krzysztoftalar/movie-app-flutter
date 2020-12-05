part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class GetMovieDetailEvent extends MovieEvent {
  final int movieId;

  GetMovieDetailEvent({
    @required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}
