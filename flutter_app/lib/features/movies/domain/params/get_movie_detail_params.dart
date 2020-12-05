import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetMovieDetailParams extends Equatable {
  final int id;

  GetMovieDetailParams({
    @required this.id,
  });

  @override
  List<Object> get props => [id];
}
