import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget studentCount(String count) {
  return Text(
    "${'student_num'.tr()} $count",
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    ),
  );
}
