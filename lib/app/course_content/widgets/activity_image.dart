import 'package:flutter/material.dart';

Widget activityImage({
  required String modName,
  required String resourceType,
}) {
  if (modName == 'page') {
    return Image.asset(
      'assets/icons/icons_video.png',
      height: 35,
    );
  }
  if (modName == 'resource' && modName == 'resource') {
    return Image.asset(
      'assets/icons/icons_video.png',
      height: 35,
    );
  }

  if (modName == 'quiz' && modName == 'quiz') {
    return Image.asset(
      'assets/icons/icons_question.png',
      height: 35,
    );
  }

  if (modName == 'testnew') {
    return Image.asset(
      'assets/icons/icons_pdf.png',
      height: 35,
    );
  }
  if (modName == 'assign') {
    return Image.asset(
      'assets/icons/icons_assignment.png',
      height: 35,
    );
  }

  return Image.asset(
    'assets/icons/icons_question.png',
    height: 35,
  );
}