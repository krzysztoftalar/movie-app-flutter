import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'components/similar_movies.dart';
import 'components/movie_cast.dart';
import '../../../../../style/typography.dart';
import './components/movie_summary.dart';
import '../../widgets/movie_rating.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../data/api/movie_api_constants.dart';
import '../../../../../style/sizes.dart';
import '../../../../../style/hue.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../di/injection_container.dart';
import '../../blocs/movie_bloc/movie_bloc.dart';

class MoviesDetailPage extends StatefulWidget {
  @override
  _MoviesDetailPageState createState() => _MoviesDetailPageState();
}

class _MoviesDetailPageState extends State<MoviesDetailPage> {
  MovieBloc _movieBloc;
  bool _isInit = true;

  @override
  void initState() {
    super.initState();
    _movieBloc = sl<MovieBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final movieId = ModalRoute.of(context).settings.arguments as int;
      _movieBloc.add(GetMovieDetailEvent(movieId: movieId));
      _isInit = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _movieBloc.close();
  }

  Widget _buildImage(MovieDetail movie) {
    if (movie.backdropPath != null) {
      return CachedNetworkImage(
        imageUrl: '${ApiConstants.MOVIE_BASE_IMAGE_URL}${movie.backdropPath}',
        fit: BoxFit.cover,
      );
    } else {
      return Container();
    }
  }

  Widget _buildFlexibleSpaceBar(MovieDetail movie) {
    return FlexibleSpaceBar(
      title: Padding(
        padding: const EdgeInsets.only(right: Sizes.dimen_60),
        child: Text(
          movie.title,
          style: TextStyle(
            fontSize: Sizes.dimen_12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      background: Stack(
        fit: StackFit.expand,
        children: [
          _buildImage(movie),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // stops: [
                //   0.1,
                //   0.9,
                // ],
                colors: [
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverList(MovieDetail movie) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(movie.voteAverage.toStringAsFixed(1)),
            SizedBox(width: Sizes.dimen_10),
            MovieRating(voteAverage: movie.voteAverage),
          ],
        ),
        SizedBox(height: Sizes.dimen_20),
        Text(
          'OVERVIEW',
          style: sectionTitle(),
        ),
        SizedBox(height: Sizes.dimen_10),
        Text(
          movie.overview,
          style: TextStyle(
            fontSize: Sizes.dimen_12,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        SizedBox(height: Sizes.dimen_20),
        MovieSummary(movie: movie),
        MovieCast(movieId: movie.id),
        SimilarMovies(movieId: movie.id),
      ]),
    );
  }

  Widget _buildMoviesDetailPage(MovieDetail movie) {
    return SliverFab(
      expandedHeight: Sizes.dimen_200,
      floatingPosition: FloatingPosition(right: Sizes.dimen_20),
      floatingWidget: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        // TODO play trailer
        onPressed: () {},
      ),
      slivers: [
        SliverAppBar(
          backgroundColor: Hue.main,
          expandedHeight: Sizes.dimen_200,
          pinned: true,
          flexibleSpace: _buildFlexibleSpaceBar(movie),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(Sizes.dimen_20),
          sliver: _buildSliverList(movie),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _movieBloc,
      child: Scaffold(
        backgroundColor: Hue.main,
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (_, state) {
            if (state is MovieInitial) {
              return Center(child: Text('Initial'));
            } else if (state is MovieError) {
              return Center(child: Text(state.message));
            } else if (state is MovieLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieLoaded) {
              return _buildMoviesDetailPage(state.movie);
            }
            return Center(child: const Text(UNEXPECTED_FAILURE_MESSAGE));
          },
        ),
      ),
    );
  }
}
