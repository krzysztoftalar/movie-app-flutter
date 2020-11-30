import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetMoviesByGenreParams extends Equatable {
  final int id;
  final int page;

  GetMoviesByGenreParams({
    @required this.id,
    @required this.page,
  });

  @override
  List<Object> get props => [id, page];
}