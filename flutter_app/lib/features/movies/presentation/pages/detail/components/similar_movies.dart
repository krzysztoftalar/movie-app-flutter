import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/api/movie_api_constants.dart';
import '../../../../domain/entities/movie.dart';
import '../../../widgets/movie_rating.dart';
import '../../../../../../style/hue.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../style/sizes.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../style/typography.dart';
import '../../../../../../di/injection_container.dart';
import '../../../blocs/similar_movies/similar_movies_bloc.dart';

class SimilarMovies extends StatefulWidget {
  final int movieId;

  SimilarMovies({
    @required this.movieId,
  });

  @override
  _SimilarMoviesState createState() => _SimilarMoviesState();
}

class _SimilarMoviesState extends State<SimilarMovies> {
  SimilarMoviesBloc _similarMoviesBloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _similarMoviesBloc = sl<SimilarMoviesBloc>();

    _similarMoviesBloc.add(GetSimilarMoviesEvent(
      movieId: widget.movieId,
      page: 1,
    ));

    _scrollController.addListener(() {
      if (_isEndScroll) {
        _getNextSimilarMovies();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _similarMoviesBloc.close();
  }

  void _getNextSimilarMovies() {
    if (_similarMoviesBloc.state is SimilarMoviesLoaded) {
      final state = _similarMoviesBloc.state as SimilarMoviesLoaded;
      _similarMoviesBloc.add(GetSimilarMoviesEvent(
        movieId: widget.movieId,
        page: state.page + 1,
      ));
    }
  }

  bool get _isEndScroll {
    if (!_scrollController.hasClients) {
      return false;
    }
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }

  Widget _buildImage(List<Movie> movies, int index) {
    double margin = movies.length - 1 == index ? Sizes.dimen_0 : Sizes.dimen_20;
    return Container(
      margin: EdgeInsets.only(right: margin),
      width: Sizes.dimen_120,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_2)),
        child: CachedNetworkImage(
          imageUrl:
              '${ApiConstants.MOVIE_BASE_IMAGE_URL}${movies[index].posterPath}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRating(Movie movie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          movie.voteAverage.toStringAsFixed(1),
          style: TextStyle(
            color: Hue.white,
            fontSize: Sizes.dimen_10,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: Sizes.dimen_6),
        MovieRating(
          voteAverage: movie.voteAverage,
          itemSize: Sizes.dimen_12,
        ),
      ],
    );
  }

  Widget _buildSimilarMoviesWidget(SimilarMoviesLoaded state) {
    if (state.movies.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: Sizes.dimen_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SIMILAR MOVIES',
              style: sectionTitle(),
            ),
            SizedBox(height: Sizes.dimen_20),
            Container(
              height: Sizes.dimen_250,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: state.movies.length,
                itemBuilder: (ctx, index) => SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacementNamed(
                      Routes.MOVIES_DETAIL_PAGE,
                      arguments: state.movies[index].id,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImage(state.movies, index),
                        SizedBox(height: Sizes.dimen_10),
                        Container(
                          width: Sizes.dimen_110,
                          child: Text(
                            state.movies[index].title,
                            style: sectionTitle(Hue.white, 1.4),
                          ),
                        ),
                        SizedBox(height: Sizes.dimen_10),
                        _buildRating(state.movies[index]),
                      ],
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
    return BlocProvider(
      create: (_) => _similarMoviesBloc,
      child: BlocBuilder<SimilarMoviesBloc, SimilarMoviesState>(
        builder: (_, state) {
          if (state is SimilarMoviesInitial) {
            return Center(child: Text('Initial'));
          } else if (state is SimilarMoviesError) {
            return Center(child: Text(state.message));
          } else if (state is SimilarMoviesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SimilarMoviesLoaded) {
            return _buildSimilarMoviesWidget(state);
          }
          return Center(child: const Text(UNEXPECTED_FAILURE_MESSAGE));
        },
      ),
    );
  }
}
