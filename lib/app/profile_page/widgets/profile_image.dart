import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/strings.dart';

Widget profileImage() {
  return Stack(
    children: [
      CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(
          defaultImage,
        ),
      ),
      Positioned(
        right: 0,
        bottom: 10,
        child: CircleAvatar(
          backgroundColor: mainColor,
          radius: 16,
          child: IconButton(
            icon: const Icon(
              Icons.camera_alt,
              color: whiteColor,
              size: 16,
            ),
            onPressed: () {},
          ),
        ),
      )
    ],
  );
}
