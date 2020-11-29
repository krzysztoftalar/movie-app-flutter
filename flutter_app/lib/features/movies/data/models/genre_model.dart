import 'package:flutter/foundation.dart';

import '../../domain/entities/genre.dart';

class GenreModel extends Genre {
  final int id;
  final String name;

  GenreModel({
    @required this.id,
    @required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
