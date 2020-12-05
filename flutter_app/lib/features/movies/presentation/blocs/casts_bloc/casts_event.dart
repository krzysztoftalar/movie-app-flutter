part of 'casts_bloc.dart';

abstract class CastsEvent extends Equatable {}

class GetCastsForMovieEvent extends CastsEvent {
  final int movieId;

  GetCastsForMovieEvent({
    @required this.movieId,
  });

  @override
  List<Object> get props => [movieId];
}
