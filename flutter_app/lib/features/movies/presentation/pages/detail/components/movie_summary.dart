import 'package:flutter/material.dart';

import '../../../../../../style/typography.dart';
import '../../../../../../style/sizes.dart';
import '../../../../../../style/hue.dart';
import '../../../../domain/entities/movie_detail.dart';

class MovieSummary extends StatelessWidget {
  final MovieDetail movie;

  MovieSummary({
    @required this.movie,
  });

  Widget _buildDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BUDGET',
              style: sectionTitle(),
            ),
            SizedBox(height: Sizes.dimen_10),
            Text(
              '\$${movie.budget.toString()}',
              style: sectionTitle(Hue.orange),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DURATION',
              style: sectionTitle(),
            ),
            SizedBox(height: Sizes.dimen_10),
            Text(
              '${movie.runtime}min',
              style: sectionTitle(Hue.orange),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RELEASE DATE',
              style: sectionTitle(),
            ),
            SizedBox(height: Sizes.dimen_10),
            Text(
              movie.releaseDate,
              style: sectionTitle(Hue.orange),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildGenres() {
    if (movie.genres.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: Sizes.dimen_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GENRES',
              style: sectionTitle(),
            ),
            SizedBox(height: Sizes.dimen_20),
            Container(
              height: Sizes.dimen_40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movie.genres.length,
                itemBuilder: (ctx, index) => Container(
                  margin: const EdgeInsets.only(right: Sizes.dimen_12),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(Sizes.dimen_6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Hue.white),
                    borderRadius: BorderRadius.circular(Sizes.dimen_6),
                  ),
                  child: Text(
                    movie.genres[index].name,
                    style: TextStyle(
                      fontSize: Sizes.dimen_12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetails(),
        _buildGenres(),
      ],
    );
  }
}
