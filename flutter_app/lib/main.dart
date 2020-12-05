import 'package:flutter/material.dart';
import './di/injection_container.dart' as di;

import './style/hue.dart';
import './features/movies/presentation/pages/detail/movies_detail_page.dart';
import './features/movies/presentation/pages/home/movies_home_page.dart';
import './core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Hue.orange,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Hue.white,
          ),
        ),
      ),
      home: MoviesHomePage(),
      routes: {
        Routes.MOVIES_DETAIL_PAGE: (_) => MoviesDetailPage(),
      },
    );
  }
}
