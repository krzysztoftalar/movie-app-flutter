import 'package:flutter/foundation.dart';

import 'movie_model.dart';

class MovieResultModel {
  List<MovieModel> movies;

  MovieResultModel({
    @required this.movies,
  });

  MovieResultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies =
          (json['results'] as List).map((x) => MovieModel.fromJson(x)).toList();
    }
  }
}
