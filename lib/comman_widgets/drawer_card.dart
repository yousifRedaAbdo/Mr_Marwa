import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/spaces.dart';
import '../utils/texts.dart';

Widget drawerCard({
  required String text,
}) {
  return Card(
    child: Container(
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradColor1, gradColor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      width: double.infinity,
      child: Row(
        children: [
          Container(
            color: grey,
            width: 15,
            height: 55,
          ),
          widthSpace(10),
          title(text, color: whiteColor)
        ],
      ),
    ),
  );
}
