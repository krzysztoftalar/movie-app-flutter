import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/movie_rating.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../style/hue.dart';
import '../../../blocs/genre_bloc/genre_bloc.dart';
import '../../../../../../style/sizes.dart';
import '../../../../domain/entities/movie.dart';
import '../../../../data/api/movie_api_constants.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    Key key,
    @required this.movie,
  }) : super(key: key);

  Widget _buildImage(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.MOVIES_DETAIL_PAGE, arguments: movie.id),
        child: Container(
          padding: const EdgeInsets.all(Sizes.dimen_6),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_24)),
            child: movie.posterPath != null
                ? CachedNetworkImage(
                    imageUrl:
                        '${ApiConstants.MOVIE_BASE_IMAGE_URL}${movie.posterPath}',
                    fit: BoxFit.cover,
                  )
                : FittedBox(
                    fit: BoxFit.fill,
                    child: Icon(
                      Icons.image_not_supported,
                      color: Hue.main,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      movie.title,
      textAlign: TextAlign.center,
      style: const TextStyle(
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
                      padding: const EdgeInsets.all(Sizes.dimen_6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Hue.white),
                        borderRadius: BorderRadius.circular(Sizes.dimen_14),
                      ),
                      child: Text(
                        genre.name,
                        style: TextStyle(
                          fontSize: Sizes.dimen_14,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(movie.voteAverage.toStringAsFixed(1)),
        SizedBox(width: Sizes.dimen_10),
        MovieRating(voteAverage: movie.voteAverage),
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
          borderRadius: const BorderRadius.all(
            Radius.circular(Sizes.dimen_30),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.dimen_10,
          vertical: Sizes.dimen_12,
        ),
        child: Column(
          children: [
            _buildImage(context),
            const SizedBox(height: Sizes.dimen_4),
            _buildTitle(),
            const SizedBox(height: Sizes.dimen_10),
            _buildGenres(context),
            const SizedBox(height: Sizes.dimen_10),
            _buildRating(),
          ],
        ),
      ),
    );
  }
}
