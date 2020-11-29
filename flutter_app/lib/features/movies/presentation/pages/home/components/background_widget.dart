import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:cached_network_image/cached_network_image.dart";

import '../../../../../../style/hue.dart';
import '../../../../data/api/movie_api_constants.dart';
import '../../../blocs/movie_bloc/movie_bloc.dart';

class BackgroundWidget extends StatelessWidget {
  final PageController controller;

  const BackgroundWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoaded) {
          return PageView.builder(
            reverse: true,
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl:
                          '${ApiConstants.MOVIE_BASE_IMAGE_URL}${state.movies[index].posterPath}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Hue.white.withOpacity(0.0001),
                          Hue.white,
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return null;
      },
    );
  }
}
