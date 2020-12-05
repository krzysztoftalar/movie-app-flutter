import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import './genre.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final List<Genre> genres;
  final double voteAverage;
  final String backdropPath;
  final String releaseDate;
  final String overview;
  final int runtime;
  final int budget;

  MovieDetail({
    @required this.id,
    @required this.title,
    @required this.genres,
    @required this.voteAverage,
    @required this.backdropPath,
    @required this.releaseDate,
    @required this.overview,
    @required this.runtime,
    @required this.budget,
  });

  @override
  List<Object> get props => [id, title];
}
