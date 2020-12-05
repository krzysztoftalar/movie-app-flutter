import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetMoviesParams extends Equatable {
  final int page;

  GetMoviesParams({@required this.page});

  @override
  List<Object> get props => [page];
}