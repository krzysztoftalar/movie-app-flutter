import 'package:flutter/material.dart';

import '../../../widgets/logo.dart';
import '../../../../../../style/sizes.dart';
import '../../../../../../style/hue.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          top: Sizes.dimen_30,
          left: Sizes.dimen_16,
          right: Sizes.dimen_16,
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Hue.white,
                size: Sizes.dimen_30,
              ),
              onPressed: null,
            ),
            Expanded(child: Logo(height: Sizes.dimen_40)),
            IconButton(
              icon: Icon(
                Icons.search,
                color: Hue.white,
                size: Sizes.dimen_30,
              ),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}
