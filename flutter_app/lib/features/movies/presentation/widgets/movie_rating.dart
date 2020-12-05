import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../style/hue.dart';
import '../../../../style/sizes.dart';

class MovieRating extends StatelessWidget {
  final double voteAverage;
  final double itemSize;

  MovieRating({
    @required this.voteAverage,
    this.itemSize = Sizes.dimen_16,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: itemSize,
      initialRating: voteAverage / 2,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      unratedColor: Hue.white,
      itemPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_2),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Hue.orange,
      ),
      onRatingUpdate: null,
    );
  }
}
