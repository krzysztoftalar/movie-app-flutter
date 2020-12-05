import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../style/hue.dart';
import '../../../../data/api/movie_api_constants.dart';
import '../../../../../../style/sizes.dart';
import '../../../../../../style/typography.dart';
import '../../../../domain/entities/cast.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../di/injection_container.dart';
import '../../../blocs/casts_bloc/casts_bloc.dart';

class MovieCast extends StatefulWidget {
  final int movieId;

  MovieCast({
    @required this.movieId,
  });

  @override
  _MovieCastState createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  CastsBloc _castsBloc;

  @override
  void initState() {
    super.initState();
    _castsBloc = sl<CastsBloc>();
    _castsBloc.add(GetCastsForMovieEvent(movieId: widget.movieId));
  }

  @override
  void dispose() {
    super.dispose();
    _castsBloc.close();
  }

  Widget _buildAvatar(Cast cast) {
    return cast.img != null
        ? Container(
            width: Sizes.dimen_70,
            height: Sizes.dimen_70,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(Sizes.dimen_100),
              ),
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.MOVIE_SMALL_IMAGE_URL}${cast.img}',
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            width: Sizes.dimen_70,
            height: Sizes.dimen_70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Hue.orange,
            ),
            child: Icon(
              FontAwesomeIcons.userAlt,
              color: Hue.white,
            ),
          );
  }

  Widget _buildMovieCastWidget(List<Cast> cast) {
    if (cast.isNotEmpty) {
      return Container(
        margin: const EdgeInsets.only(top: Sizes.dimen_20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CAST',
              style: sectionTitle(),
            ),
            SizedBox(height: Sizes.dimen_20),
            Container(
              height: Sizes.dimen_140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cast.length,
                itemBuilder: (ctx, index) => Container(
                  margin: EdgeInsets.only(
                      right: cast.length - 1 == index
                          ? Sizes.dimen_0
                          : Sizes.dimen_20),
                  width: Sizes.dimen_100,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildAvatar(cast[index]),
                        SizedBox(height: Sizes.dimen_10),
                        Text(
                          cast[index].name,
                          style: sectionTitle(Hue.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Sizes.dimen_10),
                        Text(
                          cast[index].character,
                          style: sectionTitle(),
                          textAlign: TextAlign.center,
                        ),
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
    return BlocProvider<CastsBloc>(
      create: (_) => _castsBloc,
      child: BlocBuilder<CastsBloc, CastsState>(
        builder: (ctx, state) {
          if (state is CastsInitial) {
            return Center(child: Text('Initial'));
          } else if (state is CastsError) {
            return Center(child: Text(state.message));
          } else if (state is CastsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CastsLoaded) {
            return _buildMovieCastWidget(state.casts);
          }
          return Center(child: const Text(UNEXPECTED_FAILURE_MESSAGE));
        },
      ),
    );
  }
}
