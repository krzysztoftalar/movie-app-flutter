import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Cast extends Equatable {
  final int id;
  final String name;
  final String character;
  final String img;

  Cast({
    @required this.id,
    @required this.name,
    @required this.character,
    @required this.img,
  });

  @override
  List<Object> get props => [id];
}
