import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/style/hue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/movies_bloc/movies_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../blocs/genre_bloc/genre_bloc.dart';
import './components/background_widget.dart';
import '../../../../../di/injection_container.dart';
import './components/genres_list.dart';
import './components/home_app_bar.dart';

class MoviesHomePage extends StatefulWidget {
  @override
  _MoviesHomePage createState() => _MoviesHomePage();
}

class _MoviesHomePage extends State<MoviesHomePage> {
  final pageController = PageController();
  MoviesBloc _moviesBloc;
  GenreBloc _genreBloc;

  @override
  void initState() {
    super.initState();
    _moviesBloc = sl<MoviesBloc>();
    _genreBloc = sl<GenreBloc>();

    _moviesBloc.add(GetMoviesEvent(
      page: 1,
      tabIndex: 1,
      predicate: MoviesFilter.All,
    ));
    _genreBloc.add(GetGenresEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _moviesBloc.close();
    _genreBloc.close();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _moviesBloc,
        ),
        BlocProvider(
          create: (_) => _genreBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: Hue.main,
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
