import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_app/core/error/failures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/genre_bloc/genre_bloc.dart';
import './components/background_widget.dart';
import './components/movie_card.dart';
import '../../blocs/movie_bloc/movie_bloc.dart';
import '../../../../../di/injection_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieBloc movieBloc;
  GenreBloc genreBloc;
  final controller = PageController();

  @override
  void initState() {
    super.initState();
    movieBloc = sl<MovieBloc>();
    genreBloc = sl<GenreBloc>();
    movieBloc.add(GetPlayingNowEvent());
    genreBloc.add(GetGenresEvent());
  }

  @override
  void dispose() {
    super.dispose();
    movieBloc.close();
    genreBloc.close();
  }

  Widget _buildHomeWidget(MovieLoaded state) {
    return Stack(
      children: [
        BackgroundWidget(controller: controller),
        Align(
          alignment: Alignment.bottomCenter,
          child: CarouselSlider(
            items: state.movies
                .map((item) => MovieCard(key: ValueKey(item.id), movie: item))
                .toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.7,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index, _) {
                if (index == state.movies.length - 1) {
                  movieBloc.add(GetPlayingNowEvent(page: state.page + 1));
                }
                return controller.animateToPage(
                  index,
                  duration: Duration(seconds: 1),
                  curve: Curves.ease,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => movieBloc,
        ),
        BlocProvider(
          create: (_) => genreBloc,
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state is MovieInitial) {
                  return Center(child: Text('Initial'));
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                } else if (state is MovieLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MovieLoaded) {
                  return _buildHomeWidget(state);
                }
                return const Text(UNEXPECTED_FAILURE_MESSAGE);
              },
            ),
          ],
        ),
      ),
    );
  }
}
