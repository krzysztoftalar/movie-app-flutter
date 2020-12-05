import 'package:flutter/foundation.dart';

import 'cast_model.dart';

class CastResultModel {
  List<CastModel> casts;

  CastResultModel({
    @required this.casts,
  });

  CastResultModel.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      casts = (json['cast'] as List).map((x) => CastModel.fromJson(x)).toList();
    }
  }
}
