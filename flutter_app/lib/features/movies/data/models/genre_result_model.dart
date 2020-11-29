import 'package:flutter/foundation.dart';

import 'genre_model.dart';

class GenreResultModel {
  List<GenreModel> genres;

  GenreResultModel({
    @required this.genres,
  });

  GenreResultModel.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres =
          (json['genres'] as List).map((x) => GenreModel.fromJson(x)).toList();
    }
  }
}