import 'package:flutter/foundation.dart';

import './genre_model.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/movie_detail.dart';

class MovieDetailModel extends MovieDetail {
  final int id;
  final String title;
  final List<Genre> genres;
  final double voteAverage;
  final String backdropPath;
  final String releaseDate;
  final String overview;
  final int runtime;
  final int budget;

  MovieDetailModel({
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

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      id: json['id'],
      title: json['title'],
      genres: json['genres'] != null
          ? (json['genres'] as List).map((x) => GenreModel.fromJson(x)).toList()
          : [],
      voteAverage: (json['vote_average'] as num).toDouble(),
      backdropPath: json['backdrop_path'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      runtime: json['runtime'],
      budget: json['budget'],
    );
  }
}
