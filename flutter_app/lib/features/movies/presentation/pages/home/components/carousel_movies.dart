import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/movie_bloc/movie_bloc.dart';
import '../../../../../../core/error/failures.dart';
import './movie_card.dart';

class CarouselMovies extends StatefulWidget {
  final PageController pageController;

  CarouselMovies({
    @required this.pageController,
  });

  @override
  _CarouselMoviesState createState() => _CarouselMoviesState();
}

class _CarouselMoviesState extends State<CarouselMovies> {
  MovieBloc get movieBloc => BlocProvider.of<MovieBloc>(context);

  Widget _buildCarouselMoviesWidget(BuildContext context, MovieLoaded state) {
    return CarouselSlider(
      items: state.movies
          .map((item) => MovieCard(key: ValueKey(item.id), movie: item))
          .toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.7,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        onPageChanged: (index, _) {
          if (index == state.movies.length - 1) {
            movieBloc.add(GetMoviesEvent(
              genreId: state.genreId,
              page: state.page + 1,
              tabIndex: state.tabIndex,
              predicate: state.predicate,
            ));
          }
          return widget.pageController.animateToPage(
            index,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (_, state) {
        if (state is MovieInitial) {
          return Center(child: Text('Initial'));
        } else if (state is MovieError) {
          return Center(child: Text(state.message));
        } else if (state is MovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovieLoaded) {
          return _buildCarouselMoviesWidget(context, state);
        }
        return Center(child: const Text(UNEXPECTED_FAILURE_MESSAGE));
      },
    );
  }
}
