import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetSimilarMoviesParams extends Equatable {
  final int id;
  final int page;

  GetSimilarMoviesParams({
    @required this.id,
    @required this.page,
  });

  @override
  List<Object> get props => [id, page];
}
