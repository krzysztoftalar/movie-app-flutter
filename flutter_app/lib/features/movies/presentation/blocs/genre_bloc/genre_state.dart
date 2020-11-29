part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<Genre> genres;

  GenreLoaded({
    @required this.genres,
  });

  Genre getById(int id) => genres.firstWhere((x) => x.id == id);

  @override
  List<Object> get props => [genres];
}

class GenreError extends GenreState {
  final String message;

  GenreError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
