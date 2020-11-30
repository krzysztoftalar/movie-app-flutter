import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetMovieParams extends Equatable {
  final int page;

  GetMovieParams({@required this.page});

  @override
  List<Object> get props => [page];
}