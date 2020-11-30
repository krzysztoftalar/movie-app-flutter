import 'package:flutter/material.dart';
import 'package:flutter_app/style/hue.dart';
import './di/injection_container.dart' as di;

import 'features/movies/presentation/pages/home/home_page.dart';

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
      ),
      home: HomePage(),
    );
  }
}
