import 'package:flutter/material.dart';

import './hue.dart';
import './sizes.dart';

TextStyle sectionTitle([Color color = Hue.greyDark, double height = 1.2]) =>
    TextStyle(
      color: color,
      fontSize: Sizes.dimen_12,
      fontWeight: FontWeight.w500,
      height: height,
    );
