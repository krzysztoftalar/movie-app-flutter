import 'package:flutter/foundation.dart';

import '../../domain/entities/cast.dart';

class CastModel extends Cast {
  final int id;
  final String name;
  final String character;
  final String img;

  CastModel({
    @required this.id,
    @required this.name,
    @required this.character,
    @required this.img,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      img: json['profile_path'],
    );
  }
}
