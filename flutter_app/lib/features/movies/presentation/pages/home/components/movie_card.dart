import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../core/error/failures.dart';
import '../../../../../../style/hue.dart';
import '../../../blocs/genre_bloc/genre_bloc.dart';
import '../../../../../../style/size_constants.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../data/api/movie_api_constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    Key key,
    @required this.movie,
  }) : super(key: key);

  Widget _buildImage() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(Sizes.dimen_6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_24)),
          child: CachedNetworkImage(
            imageUrl: '${ApiConstants.MOVIE_BASE_IMAGE_URL}${movie.posterPath}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      movie.title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Sizes.dimen_20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildGenres(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreLoaded) {
          final genres = movie.genreIds.map((id) => state.getById(id)).toList();
          return Wrap(
            alignment: WrapAlignment.center,
            runSpacing: Sizes.dimen_8,
            children: genres
                .map(
                  (genre) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Sizes.dimen_4),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Hue.greyDark),
                        borderRadius: BorderRadius.circular(Sizes.dimen_14),
                      ),
                      padding: const EdgeInsets.all(Sizes.dimen_6),
                      child: Text(
                        genre.name,
                        style: TextStyle(
                          color: Hue.greyDark,
                          fontSize: Sizes.dimen_14,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }
        return const Text(UNEXPECTED_FAILURE_MESSAGE);
      },
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(movie.voteAverage.toStringAsFixed(1)),
        SizedBox(width: Sizes.dimen_10),
        RatingBar.builder(
          itemSize: Sizes.dimen_16,
          initialRating: movie.voteAverage / 2,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_2),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Hue.orange,
          ),
          onRatingUpdate: null,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.dimen_6),
      child: Container(
        decoration: BoxDecoration(
          color: Hue.white.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(Sizes.dimen_30),
            topLeft: Radius.circular(Sizes.dimen_30),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.dimen_10,
          vertical: Sizes.dimen_12,
        ),
        child: Column(
          children: [
            _buildImage(),
            const SizedBox(height: Sizes.dimen_4),
            _buildTitle(),
            const SizedBox(height: Sizes.dimen_8),
            _buildGenres(context),
            const SizedBox(height: Sizes.dimen_4),
            _buildRating(),
          ],
        ),
      ),
    );
  }
}
