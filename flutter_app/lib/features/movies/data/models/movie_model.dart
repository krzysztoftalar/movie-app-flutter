import 'package:flutter/foundation.dart';

import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  final int id;
  final String title;
  final List<int> genreIds;
  final int voteCount;
  final double voteAverage;
  final String backdropPath;
  final String posterPath;
  final String releaseDate;

  MovieModel({
    @required this.id,
    @required this.title,
    @required this.genreIds,
    @required this.voteCount,
    @required this.voteAverage,
    @required this.backdropPath,
    @required this.posterPath,
    @required this.releaseDate,
  }) : super(
          id: id,
          title: title,
          genreIds: genreIds,
          backdropPath: backdropPath,
          posterPath: posterPath,
          voteCount: voteCount,
          voteAverage: voteAverage,
          releaseDate: releaseDate,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((x) => x as int).toList(),
      voteCount: json['vote_count'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
    );
  }
}
