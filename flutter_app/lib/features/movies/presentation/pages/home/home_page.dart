import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../blocs/genre_bloc/genre_bloc.dart';
import './components/background_widget.dart';
import '../../blocs/movie_bloc/movie_bloc.dart';
import '../../../../../di/injection_container.dart';
import './components/genres_list.dart';
import './components/home_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();
  MovieBloc movieBloc;
  GenreBloc genreBloc;

  @override
  void initState() {
    super.initState();
    movieBloc = sl<MovieBloc>();
    genreBloc = sl<GenreBloc>();

    movieBloc.add(GetMoviesEvent(
      page: 1,
      tabIndex: 1,
      predicate: MoviesFilter.All,
    ));
    genreBloc.add(GetGenresEvent());
  }

  @override
  void dispose() {
    super.dispose();
    movieBloc.close();
    genreBloc.close();
    pageController.dispose();
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BackgroundWidget(pageController: pageController),
              Column(
                children: [
                  HomeAppBar(),
                  BlocBuilder<GenreBloc, GenreState>(
                    builder: (_, state) {
                      if (state is GenreInitial) {
                        return Center(child: Text('Initial'));
                      } else if (state is GenreError) {
                        return Center(child: Text(state.message));
                      } else if (state is GenreLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is GenreLoaded) {
                        return GenresList(
                          pageController: pageController,
                          genresCount: state.genres.length,
                        );
                      }
                      return Center(
                          child: const Text(UNEXPECTED_FAILURE_MESSAGE));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
