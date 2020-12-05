part of 'similar_movies_bloc.dart';

abstract class SimilarMoviesEvent extends Equatable {}

class GetSimilarMoviesEvent extends SimilarMoviesEvent {
  final int movieId;
  final int page;

  GetSimilarMoviesEvent({
    @required this.movieId,
    @required this.page,
  }) : assert(page >= 1, 'page cannot be less than 1');

  @override
  List<Object> get props => [movieId, page];
}
