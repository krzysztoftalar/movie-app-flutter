import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:cached_network_image/cached_network_image.dart";

import '../../../blocs/movies_bloc/movies_bloc.dart';
import '../../../../../../style/hue.dart';
import '../../../../data/api/movie_api_constants.dart';

class BackgroundWidget extends StatelessWidget {
  final PageController pageController;

  const BackgroundWidget({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  Widget _buildBackgroundWidget(BuildContext context, MoviesLoaded state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
        reverse: true,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: state.movies.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: state.movies[index].posterPath != null
                    ? CachedNetworkImage(
                        imageUrl:
                            '${ApiConstants.MOVIE_BASE_IMAGE_URL}${state.movies[index].posterPath}',
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Hue.white.withOpacity(0.0001),
                      Hue.white.withOpacity(0.5),
                      Hue.main,
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoaded) {
          return _buildBackgroundWidget(context, state);
        }
        return Container();
      },
    );
  }
}
