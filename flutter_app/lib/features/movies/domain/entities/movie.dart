import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final List<int> genreIds;
  final int voteCount;
  final double voteAverage;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;

  Movie({
    @required this.id,
    @required this.title,
    @required this.genreIds,
    @required this.voteCount,
    @required this.voteAverage,
    @required this.backdropPath,
    @required this.posterPath,
    @required this.releaseDate,
  });

  @override
  List<Object> get props => [id, title];
}
