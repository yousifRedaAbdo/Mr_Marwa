import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mrs_marwa/utils/spaces.dart';

Center noCoursesAvail() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/graduation_ic.png',
          height: 120,
          width: 120,
          fit: BoxFit.fill,
        ),
        heightSpace(20),
        Text(
          tr('no_courses_yet'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}
