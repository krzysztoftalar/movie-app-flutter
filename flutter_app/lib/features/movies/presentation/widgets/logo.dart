import 'package:flutter/material.dart';

import '../../../../style/hue.dart';

class Logo extends StatelessWidget {
  final double height;

  Logo({@required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      color: Hue.white,
      height: height,
    );
  }
}
