import 'package:flutter/material.dart';

import 'colors.dart';

Widget mainColorTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: mainColor,
      fontSize: 24,
      fontFamily: 'dinfont',
    ),
  );
}

Widget appBarTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: whiteColor,
      fontSize: 22,
      fontFamily: 'dinfont',
    ),
  );
}

Widget roundedButtonText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: whiteColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'dinfont',
    ),
  );
}

Widget title(String text, {Color color = blackColor}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 19,
      fontWeight: FontWeight.w700,
      fontFamily: 'dinfont',
    ),
  );
}

Widget mediumText(String text, {Color color = blackColor}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 17,
      fontWeight: FontWeight.w600,
      fontFamily: 'dinfont',
    ),
  );
}

Widget smallText(String text, {Color color = blackColor}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: 'dinfont',
    ),
  );
}

Widget smallBoldTitle(String text, {Color color = mainColor}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: 17,
      fontWeight: FontWeight.w700,
      fontFamily: 'dinfont',
    ),
  );
}

Widget normalMainBlueText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: mainColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'dinfont',
    ),
  );
}
