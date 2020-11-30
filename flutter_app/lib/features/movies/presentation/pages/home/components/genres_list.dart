import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/movie_bloc/movie_bloc.dart';
import '../../../../../../style/hue.dart';
import '../../../../../../style/sizes.dart';
import '../../../blocs/genre_bloc/genre_bloc.dart';
import './carousel_movies.dart';

const List<String> _tabBars = ['Popular', 'Playing Now', 'Soon'];

class GenresList extends StatefulWidget {
  final PageController pageController;
  final int genresCount;

  const GenresList({
    @required this.pageController,
    @required this.genresCount,
  });

  @override
  _GenresListState createState() => _GenresListState();
}

class _GenresListState extends State<GenresList>
    with SingleTickerProviderStateMixin {
  MovieBloc get movieBloc => BlocProvider.of<MovieBloc>(context);
  TabController _tabController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widget.genresCount);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _onTabBarTap(int genreId, String name) {
    movieBloc.add(GetMoviesEvent(
      page: 1,
      genreId: genreId,
      predicate: MoviesFilter.ByGenre,
    ));
  }

  void _onBottomNavigationTap(int index) {
    if (index != _selectedIndex) {
      movieBloc.add(GetMoviesEvent(
        page: 1,
        tabIndex: index,
        predicate: MoviesFilter.All,
      ));

      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildTabBar(GenreLoaded state) {
    return TabBar(
      onTap: (index) =>
          _onTabBarTap(state.genres[index].id, state.genres[index].name),
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Hue.orange,
      indicatorWeight: 3.0,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Hue.greyDark,
      labelColor: Hue.main,
      tabs: state.genres
          .map(
            (genre) => Container(
              padding: const EdgeInsets.only(
                top: Sizes.dimen_16,
                bottom: Sizes.dimen_10,
              ),
              child: Text(
                genre.name.toUpperCase(),
                style: TextStyle(
                  fontSize: Sizes.dimen_16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) => _onBottomNavigationTap(index),
      backgroundColor: Hue.white,
      selectedItemColor: Hue.orange,
      unselectedItemColor: Hue.greyDark,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedLabelStyle: TextStyle(
        fontSize: Sizes.dimen_16,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: Sizes.dimen_16,
        fontWeight: FontWeight.bold,
      ),
      items: _tabBars
          .map((item) => BottomNavigationBarItem(
                icon: Icon(Icons.local_movies),
                label: item,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, GenreState>(
      builder: (context, state) {
        if (state is GenreLoaded) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: DefaultTabController(
              length: state.genres.length,
              child: Scaffold(
                bottomNavigationBar: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTabBar(state),
                    _buildBottomNavigationBar(),
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: state.genres
                      .map((x) =>
                          CarouselMovies(pageController: widget.pageController))
                      .toList(),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
